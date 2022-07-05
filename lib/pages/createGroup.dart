import 'package:flutter/material.dart';
import 'package:gup_sup/Models/contactCardModel.dart';
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
  List<ContactCardModel> contacts = [
    ContactCardModel(
      name: 'Mantraraj',
      profilePic: 'images/myImage.jpeg',
      status: 'Har Har Mahadev',
    ),
    ContactCardModel(
      name: 'Baljot',
      profilePic: 'images/myImage.jpeg',
      status: 'Jay Jalaram',
    ),
    ContactCardModel(
      name: 'Archit',
      profilePic: 'images/myImage.jpeg',
      status: ':))',
    ),
  ];
  List<ContactCardModel> contactsSelected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('images/myImage.jpeg'),
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
                          height: 85,
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
                          if (contactsSelected[index].isSelected == true) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  contactsSelected[index].isSelected = false;
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
        ],
      ),
    );
  }
}
