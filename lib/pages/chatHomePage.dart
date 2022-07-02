import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gup_sup/customUI/chatCard.dart';
import 'package:gup_sup/Models/ChatCardModel.dart';

class chatHomePage extends StatefulWidget {
  const chatHomePage({Key? key}) : super(key: key);

  @override
  _chatHomePageState createState() => _chatHomePageState();
}

class _chatHomePageState extends State<chatHomePage> {
  User? loggedInUser = FirebaseAuth.instance.currentUser;

  List<String> friendUIDs = [];
  List<ChatCardModel> friendChatCards = [];
  bool isLoading = false;

  getFriendsList() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(loggedInUser!.uid)
        .collection('friends')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                friendUIDs.add(doc['friendUID']);
              })
            });
    setState(() {
      isLoading = false;
    });
  }

  getFriendsInfo() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                friendChatCards.add(ChatCardModel(
                    profilePic: doc['profilePictureURL'],
                    name: doc['name'],
                    isGroup: doc['isGroup']));
              })
            });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFriendsList();
    getFriendsInfo();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.black12,
              child: const SpinKitThreeBounce(
                color: Color(0xffE76F52),
              ),
            ),
          )
        : ListView.builder(
            itemCount: friendChatCards.length,
            itemBuilder: (context, index) =>
                ChatCard(chatCardModel: friendChatCards[index]),
          );
  }
}
