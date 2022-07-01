import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gup_sup/Screens/homeScreen.dart';
import 'package:image_picker/image_picker.dart';

class UploadProfile extends StatefulWidget {
  String? userId;
  UploadProfile({required this.userId, Key? key}) : super(key: key);

  @override
  _UploadProfileState createState() => _UploadProfileState();
}

class _UploadProfileState extends State<UploadProfile> {
  late String? profilePictureURL;
  File? image;
  final imagePicker = ImagePicker();
  bool isLoading = false;
  pickImageMethod() async {
    setState(() {
      isLoading = true;
    });
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      isLoading = false;
    });
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    } else {
      showSnackBar(msg: 'Image not selected');
    }
  }

  // uploading file to firestore storage and getting url of that image
  Future uploadImage() async {
    setState(() {
      isLoading = true;
    });
    String profileId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${widget.userId}profilePicture")
        .child('profile_$profileId');
    await ref.putFile(image!);
    profilePictureURL = await ref.getDownloadURL();

    // saving URL to firestore database
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .update({'profilePictureURL': profilePictureURL});
    setState(() {
      isLoading = false;
    });
  }

  showSnackBar({required String msg}) {
    final snackBar = SnackBar(
      content: Text(
        msg,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height / 8,
                        backgroundImage: image == null
                            ? const AssetImage('images/generalProfile.jpeg')
                            : FileImage(image!) as ImageProvider,
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        onTap: () {
                          pickImageMethod();
                        },
                        child: const Icon(
                          Icons.add_photo_alternate,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 18,
                ),
                const Center(
                  child: Text(
                    'Please set your profile picture',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff4E5152),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    right: 25,
                  ),
                  child: InkWell(
                    onTap: () async {
                      if (image != null) {
                        await uploadImage().whenComplete(
                          () =>
                              showSnackBar(msg: 'Image Uploaded Successfully'),
                        );
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      } else {
                        showSnackBar(msg: 'Please select an image');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffE76F52),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Save and Continue',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 28,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    right: 25,
                  ),
                  child: InkWell(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffE76F52),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            isLoading
                ? Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        color: Colors.black12,
                        child: SpinKitThreeBounce(
                          color: const Color(0xffE76F52),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
