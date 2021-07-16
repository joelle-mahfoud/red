import 'package:flutter/material.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/about.dart';

import '../../../size_config.dart';

class Plan extends StatelessWidget {
  const Plan({
    Key key,
    this.itemList,
    this.urlImage,
  }) : super(key: key);

  final Future<List<Benefits>> itemList;
  final String urlImage;

  Widget singleItemList(String val) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(
                      SizeConfig.screenWidth * 0.05),
                ),
                Icon(
                  Icons.check_outlined,
                  size: 20,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: getProportionateScreenWidth(
                      SizeConfig.screenWidth * 0.01),
                ),
                Flexible(
                  child: Text(
                    val,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenWidth(16)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: KBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height:
                  getProportionateScreenWidth(SizeConfig.screenWidth * 0.05)),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Image.network(
              root_pic + urlImage,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
              height:
                  getProportionateScreenWidth(SizeConfig.screenWidth * 0.05)),
          Expanded(
            flex: 3,
            child: FutureBuilder(
                future: itemList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          Benefits benefits = snapshot.data[i];
                          return singleItemList(benefits.benefit);
                        });
                  } else
                    return Center();
                }),
          ),

          // ListView.builder(
          //     shrinkWrap: true,
          //     itemCount: itemList.length,
          //     itemBuilder: (context, index) {
          //       if (itemList.isEmpty) {
          //         return CircularProgressIndicator();
          //       } else {
          //         return singleItemList(itemList[index]);
          //       }
          //     }),
          // ),
        ],
      ),
    );
  }
}
