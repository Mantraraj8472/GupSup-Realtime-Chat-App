import 'package:flutter/material.dart';
import 'package:gup_sup/Screens/individualChatScreen.dart';
import 'package:gup_sup/Models/ChatCardModel.dart';

class ChatCard extends StatelessWidget {
  final ChatCardModel chatCardModel;
  const ChatCard({Key? key, required this.chatCardModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IndividualChatScreen(
                    chatCardModel: chatCardModel,
                  ),
                ),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(chatCardModel.profilePic),
              ),
              title: Text(
                chatCardModel.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              subtitle: Text(
                'Current Message Here',
                style: const TextStyle(color: Colors.blue),
              ),
              trailing: Text('Time will show here'),
            ),
          ),
        ),
        const Divider(
          thickness: 0.5,
        ),
      ],
    );
  }
}
