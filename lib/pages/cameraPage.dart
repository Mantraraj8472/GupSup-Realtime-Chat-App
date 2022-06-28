import 'package:flutter/material.dart';
import 'package:gup_sup/Screens/cameraScreen.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraScreen(),
    );
  }
}
