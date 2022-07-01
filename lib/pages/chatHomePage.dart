import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gup_sup/customUI/chatCard.dart';
import 'package:gup_sup/Models/ChatCardModel.dart';

class chatHomePage extends StatefulWidget {
  const chatHomePage({Key? key}) : super(key: key);

  @override
  _chatHomePageState createState() => _chatHomePageState();
}

class _chatHomePageState extends State<chatHomePage> {
  User? loggedInUser = FirebaseAuth.instance.currentUser;

  List<ChatCardModel> chatCards = [];

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<QuerySnapshot>(
    //   stream: FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(loggedInUser!.uid)
    //       .collection('friends')
    //       .snapshots(),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return Text('Something went wrong');
    //     }
    //
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Text("Loading");
    //     }
    //
    //     return ListView(
    //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
    //         Map<String, dynamic> data =
    //             document.data()! as Map<String, dynamic>;
    //
    //         final usersList = FirebaseFirestore.instance.collection('users');
    //         late String name, profilePictureURL;
    //         List<String> friendUIDs = [];
    //         usersList
    //             .doc(loggedInUser!.uid)
    //             .collection('friends')
    //             .get()
    //             .then((QuerySnapshot querySnapshot) => {
    //                   querySnapshot.docs.forEach(
    //                     (doc) {
    //                       friendUIDs.add(doc['friendUID']);
    //                     },
    //                   ),
    //                 });
    //         return Container();
    //       }).toList(),
    //     );
    //   },
    // );
    return ListView.builder(
      itemCount: chatCards.length,
      itemBuilder: (BuildContext context, int index) => ChatCard(
        chatCardModel: chatCards[index],
      ),
    );
  }
}
