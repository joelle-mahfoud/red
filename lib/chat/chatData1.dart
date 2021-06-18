import 'dart:async';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redcircleflutter/chat/screens/ticketsList.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chatDB.dart';
import 'chatWidget.dart';
import 'constants.dart';

class ChatData1 {
  static var fm = FirebaseMessaging.instance;
  static SharedPreferences _pref;
  static String email;
  static String pass;
  static String appName = "";
  static String realClientId;
  static String currentAccountName = "";

  static Future<Null> openDialog(BuildContext context) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding:
                EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
            children: <Widget>[
              Container(
                color: themeColor,
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                height: 100.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.exit_to_app,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10.0),
                    ),
                    ChatWidget.widgetShowText(
                        'Are you sure to exit app?', '', ''),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.cancel,
                        color: Colors.white70,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    ChatWidget.widgetShowText('Cancel', '', ''),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white70,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    ChatWidget.widgetShowText('Yes', '', ''),
                  ],
                ),
              ),
            ],
          );
        })) {
      case 0:
        break;
      case 1:
        exit(0);
        break;
    }
  }

  static Future<Null> handleSignOut(BuildContext context) async {
    await Firebase.initializeApp();
    final GoogleSignIn googleSignIn = GoogleSignIn();

    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }

  static Future<bool> authUsersGoogle() async {
    await Firebase.initializeApp();
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential logInUser =
        await firebaseAuth.signInWithCredential(credential);

    if (logInUser != null) {
      // Check is already sign up
      await ChatDBFireStore.checkUserExists(
          firebaseAuth.currentUser, null, null, null, null);
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> isSignedIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    bool isLoggedIn = await googleSignIn.isSignedIn();
    return isLoggedIn;
  }

  static Future<String> signUpTicket(
      BuildContext context,
      String clientId,
      String productId,
      String poductName,
      FirebaseAuth firebaseAuth,
      String realClientId) async {
    String supportEmail = 'support' +
        clientId +
        productId +
        '@hotmail.com'; //jalal should add product id =>'support' + clientId + productId + '@hotmail.com'
    try {
      print("9");
      //Ignoring header X-Firebase-Locale because its value was null
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: supportEmail, password: '123456');
      if (userCredential != null) {
        print("10");
        // Check is already sign up
        await ChatDBFireStore.checkUserExists(
            firebaseAuth.currentUser,
            currentAccountName + "/" + poductName,
            clientId,
            productId,
            realClientId);
        print("------------------------------------------- userSupportId : " +
            userCredential.user.uid);
        return userCredential.user.uid;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // Navigator.of(context).pop();
        AwesomeDialog(
            context: context,
            title: "Error",
            body: Text("Password is to weak (support)"))
          ..show();
      } else if (e.code == 'email-already-in-use') {
        String res = await ChatDBFireStore.checkUserByEmail(supportEmail);
        print(
            "-------------------------------------------userSupportId :" + res);
        return res;
      }
      print(e);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static void signUp(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      if (userCredential != null) {
        // Check is already sign up
        await ChatDBFireStore.checkUserExists(
            FirebaseAuth.instance.currentUser, null, null, null, null);

        // await FirebaseFirestore.instance
        //     .collection("users")
        //     .add({"username": email, "email": pass});
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Navigator.of(context).pop();
        AwesomeDialog(
            context: context, title: "Error", body: Text("Password is to weak"))
          ..show();
      } else if (e.code == 'email-already-in-use') {
        try {
          // FirebaseAuth.instance.sig .auth().signInWithEmailAndPassword(email, password)
          // .then((userCredential) => {
          //   // Signed in
          //   var user = userCredential.user;
          //   // ...
          // })
          // .catch((error) => {
          //   var errorCode = error.code;
          //   var errorMessage = error.message;
          // });

          final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
          UserCredential userCredential = await firebaseAuth
              .signInWithEmailAndPassword(email: email, password: pass);
          final User logInUser = userCredential.user;
          await ChatDBFireStore.makeUserOnline(logInUser);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
          }
        }

        // Navigator.of(context).pop();
        // AwesomeDialog(
        //     context: context,
        //     title: "Error",
        //     body: Text("The account already exists for that email"))
        //   ..show();
      }
    } catch (e) {
      print(e);
    }
    ChatData1.checkUserLogin(context);
  }

  static void authUser(BuildContext context) async {
    bool isValidUser = await ChatData1.authUsersGoogle();
    print('isValid' + isValidUser.toString());
    if (isValidUser) {
      if (await ChatData1.isSignedIn()) {
        //print('sign in signin');
        ChatData1.checkUserLogin(
          context,
        );
      }
    } else {
      print('sign in fail');
      Fluttertoast.showToast(msg: "Sign in fail");
    }
  }

  static Future<String> getSupportId(String supportEmail) async {
    String value = await ChatDBFireStore.checkUserExists2(supportEmail);
    return value;

    // try {
    //   UserCredential userCredential = await FirebaseAuth.instance
    //       .signInWithEmailAndPassword(email: supportEmail, password: '123456');
    //   return userCredential.user.uid;
    // } catch (e) {
    //   return "-1";
    // }
  }

  static Future<String> loginSupport(String clientId, String productId,
      String poductName, String supportEmail, bool justSignin) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User logInSupport;
    UserCredential userCredential;
    if (justSignin) {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: supportEmail, password: '123456');
      logInSupport = userCredential.user;
    } else {
      try {
        userCredential = await firebaseAuth.createUserWithEmailAndPassword(
            email: supportEmail, password: '123456');
        logInSupport = userCredential.user;
        if (userCredential != null) {
          await ChatDBFireStore.checkUserExists(
              firebaseAuth.currentUser,
              currentAccountName + "/" + poductName,
              clientId,
              productId,
              realClientId);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          userCredential = await firebaseAuth.signInWithEmailAndPassword(
              email: supportEmail, password: '123456');
          logInSupport = userCredential.user;
        }
      } catch (e) {
        print(e);
        return "-1";
      }
    }
    return logInSupport.uid;
  }

  static Future<String> login() async {
    User logInUser;
    UserCredential userCredential;
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    var user = firebaseAuth.currentUser;
    if (user == null) {
      try {
        userCredential = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: pass);
        logInUser = userCredential.user;
        if (userCredential != null) {
          await ChatDBFireStore.checkUserExists(
              firebaseAuth.currentUser, null, null, null, null);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          userCredential = await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: pass);
          logInUser = userCredential.user;
        }
      } catch (e) {
        print(e);
      }
    } else {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: pass);
      logInUser = userCredential.user;
    }
    await ChatDBFireStore.makeUserOnline(logInUser);
    return logInUser.uid;
  }

  static initSupport(String applicationName, BuildContext context) async {
    appName = applicationName;
    _pref = await SharedPreferences.getInstance();
    email = _pref.getString(kEmailPrefKey);
    pass = _pref.getString(kPassPrefKey);
    realClientId = _pref.getString(kclientIdPrefKey);

    //startTime(context);
    await Firebase.initializeApp();
    //await FirebaseAuth.instance.signOut();

    checkUserLogin(context);

    //get token to push notifications
    fm.getToken().then((token) => {
          print("========================token========================"),
          print(token),
          print("====================================================="),
        });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
  }

  static Future<void> init(String applicationName) async {
    appName = applicationName;
    _pref = await SharedPreferences.getInstance();
    email = _pref.getString(kEmailPrefKey);
    pass = _pref.getString(kPassPrefKey);
    realClientId = _pref.getString(kclientIdPrefKey);
    currentAccountName = _pref.getString(kfnamePrefKey);

    await Firebase.initializeApp();
    await FirebaseAuth.instance.signOut();

    //get token to push notifications
    fm.getToken().then((token) => {
          print("========================token========================"),
          print(token),
          print("====================================================="),
        });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // RemoteNotification notification = message.notification;
      // AndroidNotification android = message.notification?.android;

      // // If `onMessage` is triggered with a notification, construct our own
      // // local notification to show to users using the created channel.
      // if (notification != null && android != null) {
      //   flutterLocalNotificationsPlugin.show(
      //       notification.hashCode,
      //       notification.title,
      //       notification.body,
      //       NotificationDetails(
      //         android: AndroidNotificationDetails(
      //           channel.id,
      //           channel.name,
      //           channel.description,
      //           icon: android?.smallIcon,
      //           // other properties...
      //         ),
      //       ));
      // }
    });
  }

  static Future<User> getFirebaseUser() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      firebaseUser = await FirebaseAuth.instance.authStateChanges().first;
    }
    return firebaseUser;
  }

  static checkUserLogin(BuildContext context) async {
    await Firebase.initializeApp();
    var user = await getFirebaseUser();
    if (user == null) {
      signUp(context);
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      try {
        UserCredential userCredential = await firebaseAuth
            .signInWithEmailAndPassword(email: email, password: pass);
        final User logInUser = userCredential.user;
        await ChatDBFireStore.makeUserOnline(logInUser);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Tickets(
                      currentUserId: logInUser.uid,
                      currentUserName: currentAccountName,
                    )));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  static startTime(BuildContext context) async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, checkUserLogin(context));
  }

  static bool isLastMessageLeft(var listMessage, String id, int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].get('idFrom') == id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  static bool isLastMessageLeftBySpeaking(
      var listMessage, String speaking, int index) {
    // print('*************' +
    //     listMessage[index - 1].get('speaking').toString() +
    //     " " +
    //     listMessage[index - 1].get('content'));
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].get('speaking') == speaking) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  static bool isLastMessageRight(var listMessage, String id, int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].get('idFrom') != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }
}
