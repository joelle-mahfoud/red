import 'package:flutter/material.dart';
// import 'package:redcircleflutter/constants.dart';
// import 'package:redcircleflutter/screens/sign_in/sign_in_screen.dart';
// import 'package:redcircleflutter/size_config.dart';

// This is the best practice
import '../components/splash_content.dart';
// import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   // Replace the 3 second delay with your initialization code:
    //   future: Future.delayed(Duration(seconds: 50)),
    //   builder: (context, AsyncSnapshot snapshot) {
    //     // Show splash screen while waiting for app resources to load:
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return MaterialApp(home: SplashContent());
    //     } else {
    //       // Loading is done, return the app:
    //       return MaterialApp(
    //         home: Scaffold(body: Center(child: Text('App loaded'))),
    //       );
    //     }
    //   },
    // );

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SplashContent(),
      ),
    );
  }
}
