import 'package:flutter/material.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants.dart';
// import 'package:redcircleflutter/constants.dart';

class RadioConfirmBillingCycle extends StatefulWidget {
  // List<String> questions = ["1", "2"];
  @override
  _RadioConfirmBillingCycleState createState() =>
      _RadioConfirmBillingCycleState();
}

class RadioModel {
  bool isSelected;
  final String desc;
  final String title;
  final int id;
  RadioModel(this.id, this.isSelected, this.title, this.desc);
}

class _RadioConfirmBillingCycleState extends State<RadioConfirmBillingCycle> {
  final groupValue = false;

  List<RadioModel> sampleData = []; //new List<RadioModel>();
  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // Future<String> _val;

  Future<int> getIntFromLocalMemory(String key) async {
    var pref = await SharedPreferences.getInstance();
    var number = pref.getInt(key) ?? 0;
    return number;
  }

  _handleTabSelection(int val) async {
    setState(() {
      if (val == 0) {
        sampleData.add(new RadioModel(
            1, true, 'Monthly', '3-month free trial \nthen €500/month'));
        sampleData.add(new RadioModel(
            2, false, 'Annual', '3-month free trial \nThen €5000 annualy'));
      } else if (val == 1) {
        sampleData.add(new RadioModel(
            1, true, 'Monthly', '3-month free trial \nthen €300/month'));
        sampleData.add(new RadioModel(
            2, false, 'Annual', '3-month free trial \nThen €3000 annualy'));
      }
    });
  }

  Future<int> number;
  @override
  void initState() {
    super.initState();
    getIntFromLocalMemory('plan').then((value) => {
          _handleTabSelection(value),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      height: getProportionateScreenHeight(SizeConfig.screenHeight * 0.40),
      child: ListView.builder(
        itemCount: sampleData.length,
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
            //highlightColor: Colors.red,
            splashColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;
              });
            },
            child: new RadioItem(sampleData[index]),
          );
        },
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
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
                    onChanged: (int value) {},
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _item.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      _item.desc,
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
