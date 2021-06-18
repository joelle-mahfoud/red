import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redcircleflutter/constants.dart';
import '../chatWidget.dart';
import '../constants.dart';

class Chat extends StatelessWidget {
  final String peerId;
  final String peerAvatar;
  final String peerName;
  final String currentUserId;
  final String currentUserName;
  static const String id = "chat";

  Chat(
      {Key key,
      @required this.currentUserId,
      @required this.currentUserName,
      @required this.peerId,
      @required this.peerAvatar,
      @required this.peerName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("currentUserId: " + currentUserId);
    print("currentUserName: " + currentUserName);
    print("peerId: " + peerId);
    return new Scaffold(
      backgroundColor: KBackgroundColor, //Colors.white,
      appBar: AppBar(
        leading: null,
        title: Text(peerName),
        backgroundColor: Colors.black, //themeColor,
      ),
      body: new _ChatScreen(
        currentUserId: currentUserId,
        currentUserName: currentUserName,
        peerId: peerId,
        peerAvatar: peerAvatar,
      ),
    );
  }
}

class _ChatScreen extends StatefulWidget {
  final String peerId;
  final String peerAvatar;
  final String currentUserId;
  final String currentUserName;

  _ChatScreen(
      {Key key,
      @required this.peerId,
      @required this.currentUserName,
      @required this.peerAvatar,
      @required this.currentUserId})
      : super(key: key);

  @override
  State createState() =>
      new _ChatScreenState(peerId: peerId, peerAvatar: peerAvatar);
}

class _ChatScreenState extends State<_ChatScreen> {
  _ChatScreenState({@required this.peerId, @required this.peerAvatar});

  String peerId;
  String peerAvatar;
  String id;
  var listMessage;
  String groupChatId;

  File imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;
  bool youIsTyping = false;

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);

    groupChatId = '';

    isLoading = false;
    isShowSticker = false;
    imageUrl = '';

    readLocal();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  readLocal() async {
    id = widget.currentUserId ?? '';
    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id-$peerId';
    } else {
      groupChatId = '$peerId-$id';
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'chattingWith': peerId});

    setState(() {});
  }

  Future getImage(int index) async {
    PickedFile selectedFile;

    if (kIsWeb) {
      //selectedFile=await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      selectedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    } else {
      if (index == 0)
        selectedFile =
            await ImagePicker().getImage(source: ImageSource.gallery);
      else
        selectedFile = await ImagePicker().getImage(source: ImageSource.camera);

      //imageFile =File(selectedFile.path);

    }

    if (selectedFile != null) {
      setState(() {
        //orFile=selectedFile;
        isLoading = true;
      });
      uploadFile(selectedFile);
    }
  }

  Future uploadFile(PickedFile orFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference reference =
        firebase_storage.FirebaseStorage.instance.ref().child(fileName);

    File compressedFile;
    if (!kIsWeb)
      compressedFile = await FlutterNativeImage.compressImage(orFile.path,
          quality: 80, percentage: 90);

    try {
      firebase_storage.UploadTask uploadTask;

      final metadata = firebase_storage.SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': orFile.path});

      if (kIsWeb)
        uploadTask = reference.putData(await orFile.readAsBytes(), metadata);
      else
        uploadTask = reference.putFile(compressedFile);

      firebase_storage.TaskSnapshot storageTaskSnapshot = await uploadTask;

      storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
        imageUrl = downloadUrl;
        setState(() {
          isLoading = false;
          onSendMessage(imageUrl, 1);
        });
      }, onError: (err) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: 'This file is not an image');
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();

      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom': id,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type,
            'speaking': widget.currentUserName
          },
        );
      });
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  Future<bool> onBackPress() {
    Navigator.pop(context);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              ChatWidget.widgetChatBuildListMessage(groupChatId, listMessage,
                  widget.currentUserId, peerAvatar, listScrollController, null),

              // Input content
              // SizedBox(
              //   height: 10,
              // ),
              buildInput(),
              // SizedBox(
              //   height: 10,
              // )
            ],
          ),

          // Loading
          buildLoading()
        ],
      ),
      onWillPop: onBackPress,
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
              ),
              color: Colors.white.withOpacity(0.8),
            )
          : Container(),
    );
  }

  Widget buildInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            // Button send image
            new Container(
              decoration:
                  BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
              // margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.image),
                onPressed: () => getImage(0),
                color: Colors.white,
                iconSize: 20,
              ),
              width: 35,
              height: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Visibility(
              visible: !kIsWeb,
              child: new Container(
                decoration:
                    BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
                // margin: new EdgeInsets.symmetric(horizontal: 1.0),
                child: new IconButton(
                  icon: new Icon(Icons.camera_alt),
                  onPressed: () => getImage(1),
                  color: Colors.white,
                  iconSize: 20,
                ),
                width: 35,
                height: 35,
              ),
            ),

            // Edit text
            Flexible(
              child: TextFormField(
                focusNode: focusNode,
                style: TextStyle(color: Colors.white, fontSize: 15.0),
                controller: textEditingController,
                // obscureText: !_passwordVisible, //This will obscure text dynamically
                // onSaved: (newValue) => password = newValue,
                onChanged: (value) {
                  setState(() {
                    youIsTyping = (value.isNotEmpty);
                  });
                  return null;
                },
                validator: (value) {
                  return null;
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(),
                  hintText: 'Type your message',
                  hintStyle: TextStyle(color: greyColor),
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),

            // Edit text
            // Flexible(
            //   child: TextField(
            //     style: TextStyle(color: Colors.white, fontSize: 15.0),
            //     controller: textEditingController,
            //     decoration: InputDecoration(
            //       border: UnderlineInputBorder(),
            //       focusedBorder: UnderlineInputBorder(),
            //       enabledBorder: UnderlineInputBorder(),
            //       hintText: 'Type your message',
            //       hintStyle: TextStyle(color: greyColor),
            //       contentPadding: EdgeInsets.all(20),
            //     ),
            //     focusNode: focusNode,
            //   ),
            // ),

            // Flexible(
            //   child: Container(
            //     child: TextField(
            //       style: TextStyle(color: Colors.white, fontSize: 15.0),
            //       controller: textEditingController,
            //       decoration: InputDecoration.collapsed(
            //         border: InputBorder.none,
            //         hintText: 'Type your message',
            //         hintStyle: TextStyle(color: greyColor),
            //       ),
            //       focusNode: focusNode,
            //     ),
            //   ),
            // ),

            // Button send message
            Visibility(
              visible: youIsTyping,
              child: new Container(
                decoration:
                    BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
                // margin: new EdgeInsets.symmetric(horizontal: 1.0),
                child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () => onSendMessage(textEditingController.text, 0),
                  color: Colors.white,
                  iconSize: 20,
                ),
                width: 35,
                height: 35,
              ),
            ),

            // Material(
            //   child: new Container(
            //     margin: new EdgeInsets.symmetric(horizontal: 8.0),
            //     child: new IconButton(
            //       icon: new Icon(Icons.send),
            //       onPressed: () => onSendMessage(textEditingController.text, 0),
            //       color: primaryColor,
            //     ),
            //   ),
            //   color: Color.fromRGBO(28, 28, 30, 1), //Colors.white,
            // ),

            SizedBox(
              width: 10,
            ),
          ],
        ),
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          color: Color.fromRGBO(28, 28, 30, 1),
          borderRadius: BorderRadius.circular(32),
        ),

        // decoration: new BoxDecoration(
        //     border: new Border(
        //         top: new BorderSide(
        //             color: Color.fromRGBO(28, 28, 30, 1), width: 0.5)),
        //     color: Color.fromRGBO(28, 28, 30, 1)),
      ),
    );
  }
}
