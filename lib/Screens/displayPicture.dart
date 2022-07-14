import 'dart:io';
import 'package:flutter/material.dart';
import 'cameraScreen.dart';

class DisplayPicture extends StatelessWidget {
  final String? imagePath;
  const DisplayPicture({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.red,
                    child: imagePath == null
                        ? Container(
                            color: Colors.black,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                          )
                        : Image.file(
                            File(imagePath!),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close),
                        color: Colors.white,
                        iconSize: 27,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.crop_rotate),
                            color: Colors.white,
                            iconSize: 27,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.emoji_emotions_outlined),
                            color: Colors.white,
                            iconSize: 27,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.title),
                            color: Colors.white,
                            iconSize: 27,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit),
                            color: Colors.white,
                            iconSize: 27,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              color: Color(0xffF5F5F5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, bottom: 4),
                      child: CircleAvatar(
                        radius: 17,
                        child: Icon(
                          Icons.camera_alt,
                          color: Color(0xff4E5152),
                        ),
                        backgroundColor: Color(0xffE2E2E2),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        margin: const EdgeInsets.only(
                          top: 8,
                          left: 2,
                          right: 2,
                          bottom: 22,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        color: const Color(0xffF5F5F5),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 5,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Add a caption...',
                              contentPadding: EdgeInsets.only(bottom: 6),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        left: 4,
                        right: 2,
                        bottom: 20,
                      ),
                      child: CircleAvatar(
                        radius: 20,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Color(0xffE76F52),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
