import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gup_sup/Firebase%20Helper/firebaseHelper.dart';
import 'package:gup_sup/Models/contactCardModel.dart';
import 'package:gup_sup/Models/userModel.dart';
import 'package:gup_sup/Screens/uploadGroupDetails.dart';
import 'package:gup_sup/customUI/ContactCard.dart';
import 'package:gup_sup/customUI/profileIcon.dart';

List<Widget> profiles = [
  CircleAvatar(
    radius: 20,
    backgroundImage: AssetImage('images/myImage.jpeg'),
  ),
];

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ContactCardModel> contacts = [];
  List<ContactCardModel> contactsSelected = [];
  bool isLoading = false;
  late UserModel loggedInUser;
  getData() async {
    setState(() {
      isLoading = true;
    });
    loggedInUser = await getLoggedInUserData();
    setState(() {
      isLoading = false;
    });
    getUsersList();
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getUsersList() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance.collection('users').get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) {
                if (FirebaseAuth.instance.currentUser!.uid != doc['uid']) {
                  contacts.add(
                    ContactCardModel(
                      name: doc['name'],
                      profilePictureURL: doc['profilePictureURL'],
                      status: doc['status'],
                      uid: doc['uid'],
                    ),
                  );
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black12,
            child: const Center(
              child: SpinKitThreeBounce(
                color: Color(0xffE76F52),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: TextButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffE2E2E2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.search,
                        color: Color(0xff4E5152),
                      ),
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              title: const Text(
                'New Group',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: loggedInUser.profilePictureURL == null
                        ? AssetImage('images/generalProfile.jpeg')
                        : NetworkImage(loggedInUser.profilePictureURL!)
                            as ImageProvider,
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                ListView.builder(
                    itemCount: contacts.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return contactsSelected.isNotEmpty
                            ? Container(
                                height: 95,
                              )
                            : Container(
                                height: 5,
                              );
                      }
                      return InkWell(
                        onTap: () {
                          if (contacts[index - 1].isSelected == false) {
                            setState(() {
                              contacts[index - 1].isSelected = true;
                              contactsSelected.add(contacts[index - 1]);
                            });
                          } else {
                            setState(() {
                              contacts[index - 1].isSelected = false;
                              contactsSelected.remove(contacts[index - 1]);
                            });
                          }
                        },
                        child: ContactCard(
                          contactCardModel: contacts[index - 1],
                        ),
                      );
                    }),

                // Used container to provide height to ListView as it is mandatory to provide height
                contactsSelected.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            height: 85,
                            color: Colors.white,
                            child: ListView.builder(
                              itemCount: contactsSelected.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                if (contactsSelected[index].isSelected ==
                                    true) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        contactsSelected[index].isSelected =
                                            false;
                                        contactsSelected
                                            .remove(contactsSelected[index]);
                                      });
                                    },
                                    child: ProfileIcon(
                                        contacts: contactsSelected[index]),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                        ],
                      )
                    : Container(),
                contactsSelected.isNotEmpty
                    ? Positioned(
                        right: MediaQuery.of(context).size.height / 30,
                        bottom: MediaQuery.of(context).size.height / 30,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UploadGroupDetails(
                                  members: contactsSelected,
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xffE76F52),
                            child: Icon(
                              CupertinoIcons.checkmark_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
  }
}
