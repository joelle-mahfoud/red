import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/about.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RadioConfirmBillingCycle extends StatefulWidget {
  final ValueChanged<String> onpackageIdChanged;
  final ValueChanged<String> onPriceChanged;
  final ValueChanged<String> onTrialChanged;
  final String cardId;
  RadioConfirmBillingCycle(
      {Key key,
      this.cardId,
      this.onpackageIdChanged,
      this.onPriceChanged,
      this.onTrialChanged})
      : super(key: key);
  @override
  _RadioConfirmBillingCycleState createState() =>
      _RadioConfirmBillingCycleState();
}

// class RadioModel {
//   bool isSelected;
//   final String desc;
//   final String title;
//   final int id;
//   RadioModel({this.id, this.isSelected, this.title, this.desc});
//   factory RadioModel.fromJson(Map<String, dynamic> json) {
//     return RadioModel(id: json['id'],
//      title: json['id'],desc: json['id']);
//   }
// }

class _RadioConfirmBillingCycleState extends State<RadioConfirmBillingCycle> {
  final groupValue = false;

  // List<RadioModel> sampleData = []; //new List<RadioModel>();
  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // Future<String> _val;

  Future<int> getIntFromLocalMemory(String key) async {
    var pref = await SharedPreferences.getInstance();
    var number = pref.getInt(key) ?? 0;
    return number;
  }

  // _handleTabSelection(int val) async {
  //   setState(() {
  //     if (val == 0) {
  //       sampleData.add(new RadioModel(
  //           1, true, 'Monthly', '3-month free trial \nthen €500/month'));
  //       sampleData.add(new RadioModel(
  //           2, false, 'Annual', '3-month free trial \nThen €5000 annualy'));
  //     } else if (val == 1) {
  //       sampleData.add(new RadioModel(
  //           1, true, 'Monthly', '3-month free trial \nthen €300/month'));
  //       sampleData.add(new RadioModel(
  //           2, false, 'Annual', '3-month free trial \nThen €3000 annualy'));
  //     }
  //   });
  // }

  Future<List<Package>> futurePackage;
  Future<List<Package>> fetchPackage() async {
    String url = root +
        "/" +
        const_get_circle_cards_packages +
        "?token=" +
        token +
        "&id=" +
        widget.cardId;
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        print(res);
        List<Package> packages =
            (res['data'] as List).map((i) => Package.fromJson(i)).toList();
        return packages;
      } else {
        print(" ${res['message']}");
        return null;
      }
    }
    throw Exception('Failed to load');
  }

  Future<int> number;
  @override
  void initState() {
    super.initState();
    futurePackage = fetchPackage();
    // getIntFromLocalMemory('plan').then((value) => {
    //       _handleTabSelection(value),
    //     });
  }

  bool firstLoad = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      height: getProportionateScreenHeight(SizeConfig.screenHeight * 0.40),
      child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Package package = snapshot.data[index];
                  if (firstLoad && index == 0) {
                    package.isSelected = true;
                    widget.onpackageIdChanged(package.id);
                    widget.onPriceChanged(package.price);
                    widget.onTrialChanged(package.freeTrial);
                  }
                  return new InkWell(
                    //highlightColor: Colors.red,
                    splashColor: Colors.blueAccent,
                    onTap: () {
                      setState(() {
                        firstLoad = false;
                        for (var i = 0; i < snapshot.data.length; i++) {
                          Package p = snapshot.data[i];
                          p.isSelected = false;
                        }
                        // futurePackage
                        //     .forEach((element) => element.isSelected = false);
                        package.isSelected = true;
                      });
                      widget.onpackageIdChanged(package.id);
                      widget.onPriceChanged(package.price);
                      widget.onTrialChanged(package.freeTrial);
                    },
                    child: new RadioItem(package),
                  );
                },
              );
            }
            return Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Text(
                  "There are no requests!",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: getProportionateScreenWidth(18)),
                ));
          },
          future: futurePackage),
    );
  }
}

class RadioItem extends StatelessWidget {
  final Package _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 100,
            width: 300,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white,
                      disabledColor: Colors.white),
                  child: Radio(
                    activeColor: kPrimaryColor,

                    // fillColor: MaterialStateColor(1),
                    value: _item.isSelected ? _item.id : 0,
                    groupValue: _item.id,
                    // groupValue: value,
                    onChanged: (value) {},
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _item.duration + " " + _item.type,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      _item.freeTrial +
                          "-month free trial \nThen €" +
                          _item.price,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            decoration: new BoxDecoration(
              // color: _item.isSelected
              //     ? Color.fromRGBO(171, 150, 94, 1)
              //     : Colors.white,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected ? kPrimaryColor : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
        ],
      ),
    );
  }
}
