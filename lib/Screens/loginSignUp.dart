import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gup_sup/Screens/LogIn.dart';
import 'package:gup_sup/Screens/SignUp.dart';

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({Key? key}) : super(key: key);

  @override
  _LoginSignUpState createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  // late AnimationController _animationController;
  // late Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 1500),
    // );
    // _animation =
    //     CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);
    // _animationController.forward();
    //
    // _animation.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      left: false,
      right: false,
      top: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  Image.asset(
                    'images/gupsup.jpeg',
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        ' GupSup',
                        textStyle: const TextStyle(
                          fontSize: 55,
                          color: Color(0xff4E5152),
                          fontWeight: FontWeight.w900,
                        ),
                        speed: const Duration(
                          milliseconds: 100,
                        ),
                      ),
                    ],
                    totalRepeatCount: 1,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                  right: 25,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogIn(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffE76F52),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                  right: 25,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ),
                    );
                  },
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
      ),
    );
  }
}
