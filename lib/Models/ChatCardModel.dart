import 'package:flutter/material.dart';

class ChatCardModel {
  late String name;
  late String currentMessage;
  late String time;
  late String profilePic;
  late bool isGroup;

  ChatCardModel(
      {required this.profilePic,
      required this.name,
      required this.currentMessage,
      required this.time,
      required this.isGroup});
}
