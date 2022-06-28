import 'package:flutter/material.dart';
import 'package:gup_sup/customUI/chatCard.dart';
import 'package:gup_sup/Models/ChatCardModel.dart';

class chatHomePage extends StatefulWidget {
  const chatHomePage({Key? key}) : super(key: key);

  @override
  _chatHomePageState createState() => _chatHomePageState();
}

class _chatHomePageState extends State<chatHomePage> {
  List<ChatCardModel> chatCards = [
    ChatCardModel(
        profilePic: 'images/myImage.jpeg',
        name: 'Mantraraj',
        currentMessage: 'Hello everyone!',
        time: '2:56',
        isGroup: false),
    ChatCardModel(
        profilePic: 'images/myImage.jpeg',
        name: 'Baljot',
        currentMessage: 'Hello ballluuuu....',
        time: '3:00',
        isGroup: false),
    ChatCardModel(
        profilePic: 'images/myImage.jpeg',
        name: 'Archit',
        currentMessage: 'Hellluu Archiii...',
        time: '2:00',
        isGroup: false),
  ];

  @override
  Widget build(BuildContext context) {
    // As we have multiple custom cards we are going to use ListViewBuilder instead of ListView
    return ListView.builder(
      itemCount: chatCards.length,
      itemBuilder: (BuildContext context, int index) => ChatCard(
        chatCardModel: chatCards[index],
      ),
    );
  }
}
