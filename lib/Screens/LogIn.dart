import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late String email, password;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Center(
                child: Image(
                  image: AssetImage('images/gupsup.webp'),
                ),
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
                  fontSize: 50,
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
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              email = value;
                            },
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return ("Please enter your Email");
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value!)) {
                                return ("Please Enter valid Email");
                              }
                              return null;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Email ID'),
                            style: const TextStyle(
                              fontSize: 20,
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
                            obscureText: true,
                            onChanged: (value) {
                              password = value;
                            },
                            validator: (value) {
                              RegExp regex = new RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return ("Please enter you password");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Password must contain at least 6 characters");
                              }
                              return null;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Password'),
                            style: const TextStyle(
                              color: Color(0xff4E5152),
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
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffE76F52),
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
