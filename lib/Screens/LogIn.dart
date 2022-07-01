import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gup_sup/Screens/homeScreen.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  Future<void> login({required String email, required String password}) async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        const snackBar = SnackBar(
          content: Text(
            'No user found for that email.',
          ),
        );
        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'wrong-password') {
        const snackBar = SnackBar(
          content: Text(
            'Wrong password provided for that user.',
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
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
                  height: MediaQuery.of(context).size.height / 5,
                ),
                Center(
                  child: Image(
                    image: AssetImage('images/gupsup.webp'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 14,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 12.0,
                  ),
                  child: Text(
                    'Login',
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
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
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
                                  print(value);
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
                      login(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffE76F52),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'LogIn',
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
