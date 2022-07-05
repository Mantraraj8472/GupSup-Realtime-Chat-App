import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gup_sup/Screens/loginSignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          try {
            await FirebaseAuth.instance.signOut().then((value) => {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginSignUp(),
                      ),
                      (route) => false),
                });
            // Now we will remove that email from key when users log out
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.remove('email');
          } catch (e) {
            final snackBar = SnackBar(
              content: Text(
                e.toString(),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Container(
          height: 50,
          width: 70,
          child: Center(child: Text('Sign Out')),
        ),
      ),
    );
  }
}
