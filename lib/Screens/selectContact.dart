import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gup_sup/customUI/ContactCard.dart';
import 'package:gup_sup/pages/createGroup.dart';
import '../Models/contactCardModel.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) => ContactCard(
          contactData: contacts[index],
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
