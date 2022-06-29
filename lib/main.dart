import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gup_sup/Screens/cameraScreen.dart';
import 'package:gup_sup/Screens/homeScreen.dart';
import 'package:gup_sup/Screens/loginSignUp.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  runApp(GupSup());
}

class GupSup extends StatelessWidget {
  const GupSup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff06F1F2),
      ),
      home: LoginSignUp(),
    );
  }
}

// WebSocket:
/*
--> WebSocket is bidirectional, a full duplex protocol. (Means both can communicate with each other and simultaneously).
--> It is a stateful protocol. (means the connection will not be ended until one of the client or server does not terminate).

Client          =====(initiate connection)=====>                     Server
                    <=====(Handshake)=====
       <=====(WebSocket (bidirectional communication))=====>

Why only WebSocket for realtime chat application?
For that we have to know about rest API.
In rest API the client will request the data from server with the help of http protocol.
(http is unidirectional and stateless protocol).
(In rest API when we send a message a connection is terminated just after getting the response from the server and for viewing message we have to reload page again and again.
So there is a solution in rest API and is pooling, that is we have to request the data again and again very frequently).
So we use WebSocket and so we establish a bidirectional connection and which is stateful.

This is the beauty of the webSocket that the message will be delivered as soon as possible and communication happen is bidirectional.


Now in frontend we have to use socket client and in backend we have to use socket server.
*/
