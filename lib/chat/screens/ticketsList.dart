import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redcircleflutter/chat/screens/ChatScreen.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/screens/home/home_screen.dart';
import 'package:redcircleflutter/size_config.dart';

List<dynamic> friendList = [];

class Tickets extends StatefulWidget {
  final String currentUserId;
  final String currentUserName;
  Tickets(
      {Key key, @required this.currentUserId, @required this.currentUserName})
      : super(key: key);
  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  _TicketsState();

  bool isLoading = false;
  final friendController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        centerTitle: true,
        title: Text(
          "CHAT",
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: getProportionateScreenHeight(23),
          ),
        ),
        backgroundColor: Colors.black, // themeColor,
      ),
      backgroundColor: KBackgroundColor,
      body: WillPopScope(
        child: showFriendList(),
        onWillPop: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
          return Future.value(false);
        },
      ),
    );
  }

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .orderBy('createdAt', descending: true)
      .snapshots();

  Widget showFriendList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Container(
          // color: Color.fromRGBO(42, 63, 84, 1),
          child: new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              String ticketName = "Support/" +
                  document.data()['ticketNumber'].toString().substring(
                      document.data()['ticketNumber'].toString().indexOf("/") +
                          1);
              String createdAt = "";
              if (document.data()['createdAt'] != null) {
                print(document.data()['createdAt'].toString());
                try {
                  Timestamp t = document.data()['createdAt'];
                  var format = new DateFormat('d MMM, hh:mm a');
                  createdAt = format.format(t.toDate());
                } catch (e) {
                  print(e.toString());
                }
              }
              bool isRead = (document.data()['IsRead'] == null ||
                  (document.data()['IsRead'] != null &&
                      document.data()['IsRead'] == true));
              return !(document.data()['clientId'] != null &&
                      document.data()['clientId'] == widget.currentUserId)
                  ? Container()
                  : new ListTile(
                      // tileColor: Color.fromRGBO(42, 63, 84, 1),
                      leading: Icon(
                        Icons.chat,
                        size: 30.0,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      trailing: isRead
                          ? Icon(
                              Icons.done_all,
                              size: 18.0,
                              color: kPrimaryColor.withOpacity(0.8),
                            )
                          : Icon(
                              Icons.done,
                              size: 18.0,
                              color: kPrimaryColor.withOpacity(0.8),
                            ),
                      title: new Text(
                        ticketName,
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      subtitle: new Text(createdAt,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8))),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                      supportId: document.data()['userId'],
                                      productId:
                                          document.data()['realProductId'],
                                      productName: ticketName,
                                      supportEmail: document.data()['email'],
                                    )));
                        // PAChat(
                        //     productid: projectSnap1.data.id,
                        //     productName:
                        //         projectSnap1.data.name)));
                      },
                    );
            }).toList(),
          ),
        );
      },
    );
  }

  // Widget showFriendList() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: _usersStream,
  //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (snapshot.hasError) {
  //         return Text('Something went wrong');
  //       }

  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Text("Loading");
  //       }

  //       return new ListView(
  //         children: snapshot.data.docs.map((DocumentSnapshot document) {
  //           String ticketName = "Support/" +
  //               document.data()['ticketNumber'].toString().substring(
  //                   document.data()['ticketNumber'].toString().indexOf("/") +
  //                       1);

  //           return !(document.data()['clientId'] != null &&
  //                   document.data()['clientId'] == widget.currentUserId)
  //               ? Container()
  //               : new ListTile(
  //                   title: new Text(ticketName),
  //                   onTap: () {
  //                     print("currentUserId : " + document.data()['userId']);
  //                     print("peerId : " + document.data()['clientId']);
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) => Chat(
  //                                   currentUserId: document.data()['clientId'],
  //                                   currentUserName: widget.currentUserName,
  //                                   peerId: document.data()['userId'],
  //                                   peerName: ticketName,
  //                                   peerAvatar: document.data()['photoUrl'],
  //                                 )));
  //                   },
  //                 );

  //           // return new ListTile(
  //           //   title: new Text(document.data()['email']),
  //           //   // subtitle: new Text(document.data()['company']),
  //           // );
  //         }).toList(),
  //       );
  //     },
  //   );
  // }
}
