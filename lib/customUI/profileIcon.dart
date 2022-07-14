import 'package:flutter/material.dart';
import 'package:gup_sup/Models/contactCardModel.dart';

class ProfileIcon extends StatefulWidget {
  late ContactCardModel contacts;
  ProfileIcon({required this.contacts, Key? key}) : super(key: key);

  @override
  _ProfileIconState createState() => _ProfileIconState();
}

class _ProfileIconState extends State<ProfileIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 8),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: const [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('images/myImage.jpeg'),
              ),
              CircleAvatar(
                radius: 11,
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 16,
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(widget.contacts.name!),
        ],
      ),
    );
  }
}
