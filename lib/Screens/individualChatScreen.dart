import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gup_sup/Models/ChatCardModel.dart';
import 'package:gup_sup/Screens/cameraScreen.dart';
import 'package:gup_sup/customUI/othersMessageCard.dart';
import 'package:gup_sup/customUI/ownMessageCard.dart';

class IndividualChatScreen extends StatefulWidget {
  late ChatCardModel chatCardModel;
  IndividualChatScreen({required this.chatCardModel});

  @override
  _IndividualChatScreenState createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  int showEmojiPicker = 0;
  // for focusing of the keyboard or textFormField
  FocusNode focusNode = FocusNode();
  // For adding emoji to textFormField we want textEditingController
  final TextEditingController _messageController = TextEditingController();
  String? profilePictureURL;
  User? loggedInUser = FirebaseAuth.instance.currentUser;

  getCurrentUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => {
              profilePictureURL = value['profilePictureURL'],
              setState(() {
                profilePictureURL;
              }),
            });
  }

  @override
  // Here are we are adding listener in focusNode
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmojiPicker = 0;
        });
      }
    });
    getCurrentUser();
  }

  // emojiSelector method
  Widget emojiSelector() {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        setState(() {
          _messageController.text = _messageController.text + emoji.emoji;
        });
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 115,
        backgroundColor: Colors.white,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffE2E2E2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      top: 5,
                      bottom: 5,
                      right: 1,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xff4E5152),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: widget.chatCardModel.profilePic == null
                    ? AssetImage('images/generalProfile.jpeg')
                    : NetworkImage(widget.chatCardModel.profilePic!)
                        as ImageProvider,
              ),
            ),
          ],
        ),
        title: InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatCardModel.name,
                  style: const TextStyle(color: Colors.black, fontSize: 18.5),
                ),
                const Text(
                  'Last seen today at 3:45',
                  style: TextStyle(color: Colors.teal, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 8,
              left: 8,
              top: 10,
              bottom: 10,
            ),
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffE2E2E2),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3.0, vertical: 2),
                  child: Icon(
                    Icons.videocam,
                    color: Color(0xff4E5152),
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              right: 12,
              left: 4,
              bottom: 10,
            ),
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffE2E2E2),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3.0, vertical: 2),
                  child: Icon(
                    Icons.call,
                    color: Color(0xff4E5152),
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white54,
        child: WillPopScope(
          onWillPop: () {
            if (showEmojiPicker == 1) {
              setState(() {
                showEmojiPicker = 0;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 160,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(loggedInUser!.uid)
                      .collection('messages')
                      .doc(widget.chatCardModel.uid)
                      .collection('indiMessages')
                      .orderBy('time')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData == false) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black12,
                        child: const Center(
                          child: SpinKitThreeBounce(
                            color: Color(0xffE76F52),
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var messageInfo = snapshot.data!.docs[index];
                          return messageInfo['isOwn']
                              ? OwnMessageCard(message: messageInfo['message'])
                              : OthersMessageCard(
                                  message: messageInfo['message']);
                        },
                      );
                    }
                  },
                ),
                // child: ListView(
                //   shrinkWrap: true,
                //   children: [],
                // ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (showEmojiPicker == 1)
                      SizedBox(
                        child: emojiSelector(),
                        height: MediaQuery.of(context).size.height / 3.2,
                      ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 90,
                      color: Color(0xffF0F0F0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                margin: const EdgeInsets.only(
                                  top: 8,
                                  left: 2,
                                  right: 2,
                                  bottom: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                color: const Color(0xffF5F5F5),
                                child: TextFormField(
                                  controller: _messageController,
                                  focusNode: focusNode,
                                  textAlignVertical: TextAlignVertical.center,
                                  // keyboardType: TextInputType.multiline,

                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Type something...',
                                    prefixIcon: IconButton(
                                      onPressed: () {
                                        focusNode.unfocus();
                                        focusNode.canRequestFocus = false;
                                        setState(() {
                                          showEmojiPicker ^= 1;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.emoji_emotions,
                                        color: Color(0xff4E5152),
                                      ),
                                    ),
                                    // contentPadding: EdgeInsets.only(bottom: 2),
                                    border: InputBorder.none,
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CameraScreen(),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.camera_alt,
                                            color: Color(0xff4E5152),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                                left: 2,
                                right: 2,
                                bottom: 22,
                              ),
                              child: CircleAvatar(
                                backgroundColor: Color(0xffE76F52),
                                radius: 24,
                                child: IconButton(
                                  onPressed: () async {
                                    if (_messageController.text.isNotEmpty) {
                                      var dateTimeNow = DateTime.now();
                                      var mssg = _messageController.text.trim();
                                      _messageController.clear();
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(loggedInUser!.uid)
                                          .collection('messages')
                                          .doc(widget.chatCardModel.uid)
                                          .collection('indiMessages')
                                          .doc()
                                          .set({
                                        'friendUID': widget.chatCardModel.uid,
                                        'message': mssg,
                                        'time': dateTimeNow,
                                        'isOwn': true,
                                      });
                                      dateTimeNow = DateTime.now();
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(widget.chatCardModel.uid)
                                          .collection('messages')
                                          .doc(loggedInUser!.uid)
                                          .collection('indiMessages')
                                          .doc()
                                          .set({
                                        'friendUID': loggedInUser!.uid,
                                        'message': mssg,
                                        'time': dateTimeNow,
                                        'isOwn': false,
                                      });
                                      _messageController.clear();
                                    }
                                  },
                                  icon: Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Icon(
                                      Icons.send_rounded,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
