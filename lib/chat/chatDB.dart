import 'dart:async';
// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class ChatDBFireStore {
  static Future<bool> isUserSignedIn() async {
    // GoogleSignInAccount? user = _currentUser;

    return false;
  }

  static String getDocName() {
    String dbUser = "users";
    return dbUser;
  }

  static updateIsDone(String userId, bool val) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update({'IsDone': val});
  }

  static updateIsRead(String userId, bool val) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update({'IsRead': val});
  }

  static Future<String> checkUserByEmail(String email) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email.toLowerCase())
        .get();
    print(querySnapshot.docs.first["userId"].toString());
    return querySnapshot.docs.first["userId"].toString();

    // FirebaseFirestore.instance
    //     .collection('users')
    //     .where('email', isEqualTo: email)
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   print('11');
    //   print('------------------- checkUserByEmail : ' +
    //       querySnapshot.docs.first["userId"].toString());
    //   return querySnapshot.docs.first["userId"].toString();
    // });
    // return '';
  }

  static Future<String> checkUserExists2(String email) async {
    QuerySnapshot result;
    try {
      result = await FirebaseFirestore.instance
          .collection(getDocName())
          .where('email', isEqualTo: email)
          .get();
    } catch (e) {
      print('ex ' + e.toString());
      return "-1";
    }

    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length > 0) {
      return documents[0].data()["userId"].toString();
    }
    return "-1";
  }

  static Future<void> checkUserExists(User logInUser, String ticketid,
      String clientId, String productId, String realClientID) async {
    QuerySnapshot result;
    try {
      result = await FirebaseFirestore.instance
          .collection(getDocName())
          .where('userId', isEqualTo: logInUser.uid)
          .get();
    } catch (e) {
      print('ex ' + e.toString());
    }

    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length == 0) {
      await saveNewUser(logInUser, ticketid, clientId, productId, realClientID);
    }
  }

  static saveNewUser(User logInUser, String ticketid, String clientId,
      String productId, String realClientID) {
    FirebaseFirestore.instance.collection(getDocName()).doc(logInUser.uid).set({
      'nickname': logInUser.email, //logInUser.displayName,
      'photoUrl': null, //logInUser.photoURL,
      'userId': logInUser.uid,
      'email': logInUser.email,
      'friends': [],
      'createdAt': Timestamp.fromDate(DateTime.now()),
      'chattingWith': null,
      'online': null,
      'speaking': logInUser.email,
      'isSupport': (ticketid != null),
      'ticketNumber': ticketid,
      'clientId': clientId,
      'IsRead': false,
      'realProductId': productId,
      'realClientId': realClientID,
      'IsDone': false
    });
  }

  static streamChatData() {
    FirebaseFirestore.instance
        .collection(ChatDBFireStore.getDocName())
        .snapshots();
  }

  static Future<void> makeUserOnline(User logInUser) async {
    FirebaseDatabase.instance
        .reference()
        .child("/status/" + logInUser.uid)
        .onDisconnect()
        .set("offline");

    FirebaseDatabase.instance
        .reference()
        .child("/status/" + logInUser.uid)
        .set("online");
  }
}
