import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gup_sup/Models/contactCardModel.dart';

class ContactCard extends StatelessWidget {
  late ContactCardModel contactData;
  ContactCard({required this.contactData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(contactData.profilePic),
              ),
              if (contactData.isSelected == true)
                CircleAvatar(
                  radius: 11,
                  backgroundColor: Colors.teal,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
            ],
          ),
          title: Text(
            contactData.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
          subtitle: Text(
            contactData.status,
            style: TextStyle(color: Colors.blue),
          ),
          trailing: Icon(
            CupertinoIcons.person_add_solid,
            color: Color(0xff4E5152),
            size: 25,
          ),
        ),
        Divider(
          thickness: 0.5,
        ),
      ],
    );
  }
}
