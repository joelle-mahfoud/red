import 'package:flutter/material.dart';

import 'package:redcircleflutter/chat/chatWidget.dart';
import 'package:redcircleflutter/chat/chatData1.dart';

class FlutterChat extends StatefulWidget {
  static String routeName = "/chat";

  static const String id = "welcome_screen";
  @override
  _FlutterChatState createState() => _FlutterChatState();
}

class _FlutterChatState extends State<FlutterChat> {
  @override
  void initState() {
    super.initState();
    ChatData1.initSupport("RedCircle Chat ", context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: ChatWidget.widgetWelcomeScreen(context),

      // Scaffold(
      //     appBar: ChatWidget.getAppBar(),
      //     backgroundColor: Colors.white,
      //     body: ChatWidget.widgetWelcomeScreen(context)),
    );
  }
}
