import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

Future<bool> onWillPop(BuildContext context) {
  return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          title: Text(
            'Exit',
            style: TextStyle(color: kPrimaryColor),
          ),
          content: Text(
            'Do you want to exit Red Circle?',
            style: TextStyle(color: kPrimaryColor),
          ),
          elevation: 100,
          backgroundColor: KBackgroundColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: kPrimaryColor.withOpacity(0.8)),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'No',
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
            TextButton(
              onPressed: () => exit(0),
              /*Navigator.of(context).pop(true)*/
              child: Text(
                'Yes',
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
          ],
        ),
      ) ??
      false;
}
