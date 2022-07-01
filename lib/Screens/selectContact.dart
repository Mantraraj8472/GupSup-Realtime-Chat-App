import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gup_sup/customUI/ContactCard.dart';
import 'package:gup_sup/pages/createGroup.dart';
import '../Models/contactCardModel.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  bool isLoading = false;
  User? loggedInUser = FirebaseAuth.instance.currentUser;
  List<String> userIDs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsersList();
  }

  addFriend({required String friendUID, required int index}) async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(loggedInUser!.uid)
        .collection('friends')
        .add({'friendUID': friendUID});
    setState(() {
      isLoading = false;
      contacts.removeAt(index);
    });
  }

  getUsersList() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance.collection('users').get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) {
                if (loggedInUser!.uid != doc['uid']) {
                  contacts.add(
                    ContactCardModel(
                      name: doc['name'],
                      profilePic: doc['profilePictureURL'],
                      status: doc['status'],
                    ),
                  );
                  userIDs.add(doc['uid']);
                }
              },
            ),
          },
        );
    setState(() {
      isLoading = false;
      contacts;
    });
  }

  List<ContactCardModel> contacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.black12,
                child: SpinKitThreeBounce(
                  color: const Color(0xffE76F52),
                ),
              ),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  addFriend(friendUID: userIDs[index], index: index);
                },
                child: ContactCard(
                  contactData: contacts[index],
                ),
              ),
            ),
      floatingActionButton: SpeedDial(
        backgroundColor: Color(0xffE76F52),
        icon: Icons.add,
        activeIcon: Icons.close,
        curve: Curves.bounceIn,
        spacing: 12,
        spaceBetweenChildren: 4,
        childrenButtonSize: Size(65, 65),
        children: [
          SpeedDialChild(
            backgroundColor: Colors.green,
            child: Icon(
              Icons.group,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateGroup()));
            },
            label: 'New Group',
          ),
          SpeedDialChild(
            backgroundColor: Colors.green,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onTap: () {},
            label: 'New Contact',
          )
        ],
      ),
    );
  }
}
