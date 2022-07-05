import 'package:flutter/material.dart';

class ChatCardModel {
  late String name;
  String? currentMessage;
  String? time;
  late String? profilePic;
  late bool? isGroup;
  String uid;

  ChatCardModel({
    required this.uid,
    required this.profilePic,
    required this.name,
    this.currentMessage,
    this.time,
    required this.isGroup,
  });
}
