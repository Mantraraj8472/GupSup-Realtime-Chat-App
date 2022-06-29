import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: Image(
                  image: AssetImage('images/gupsup.webp'),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 14,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
              ),
              child: Text(
                'SignUp',
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
                        Icon(
                          Icons.email,
                          size: 30,
                          color: Color(0xff4E5152),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              email = value;
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
                SizedBox(
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
                        Icon(
                          Icons.lock,
                          size: 30,
                          color: Color(0xff4E5152),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: TextField(
                            obscureText: true,
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Password'),
                            style: TextStyle(
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
