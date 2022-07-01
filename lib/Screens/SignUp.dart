import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gup_sup/Models/userModel.dart';
import 'package:gup_sup/Screens/homeScreen.dart';
import 'package:gup_sup/Screens/uploadProfile.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      setState(() {
        isLoading = true;
      });
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await storeDetailsToFirestore();
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        const snackBar = SnackBar(
          content: Text(
            'The password provided is too weak.',
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'email-already-in-use') {
        const snackBar = SnackBar(
          content: Text(
            'The account already exists for that email.',
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(
          e.toString(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
                Center(
                    child: Image(
                  image: AssetImage('images/gupsup.webp'),
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 14,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 12.0,
                  ),
                  child: Text(
                    'SignUp',
                    style: TextStyle(
                      fontSize: 60,
                      color: Color(0xff4E5152),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 14,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 18,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.account_circle,
                              size: 30,
                              color: Color(0xff4E5152),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Expanded(
                              child: TextFormField(
                                autofocus: false,
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                onSaved: (value) {
                                  nameController.text = value!;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Name'),
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Color(0xff4E5152),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 18,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.email,
                              size: 30,
                              color: Color(0xff4E5152),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Expanded(
                              child: TextFormField(
                                autofocus: false,
                                controller: emailController,
                                validator: (value) {
                                  if (value!.isNotEmpty) {
                                    return ("Please enter your Email");
                                  }
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return ("Please Enter valid Email");
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  emailController.text = value!;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Email ID'),
                                style: const TextStyle(
                                  color: Color(0xff4E5152),
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 18,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.lock,
                              size: 30,
                              color: Color(0xff4E5152),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Expanded(
                              child: TextFormField(
                                autofocus: false,
                                obscureText: true,
                                controller: passwordController,
                                validator: (value) {
                                  RegExp regex = RegExp(r'^.{6,}$');
                                  if (value!.isEmpty) {
                                    return ("Please enter you password");
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return ("Password must contain at least 6 characters");
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  passwordController.text = value!;
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Password'),
                                style: const TextStyle(
                                  color: Color(0xff4E5152),
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    right: 25,
                  ),
                  child: InkWell(
                    onTap: () {
                      signup(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
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
                            'SignUp',
                            style: TextStyle(
                              fontSize: 25,
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

  storeDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameController.text;

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => UploadProfile(userId: user.uid),
        ),
        (route) => false);
  }
}

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.only(bottom: 5.0, left: 5.0),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Color(0xff4E5152), width: 2),
  ),
);
