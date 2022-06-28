import 'package:flutter/material.dart';
import 'package:gup_sup/Screens/cameraScreen.dart';
import 'package:gup_sup/Screens/selectContact.dart';
import '../pages/cameraPage.dart';
import '../pages/chatHomePage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final List<Widget> _screens = <Widget>[
    chatHomePage(),
    Container(),
    Text('Index 2 screen page'),
    SelectContact(),
  ];

  void updateIndex(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraScreen(),
        ),
      );
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffE2E2E2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(
                  Icons.search,
                  color: Color(0xff4E5152),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'GupSup',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: const [
          Padding(
              padding: EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('images/myImage.jpeg'),
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedIconTheme: const IconThemeData(color: Colors.blue),
        selectedLabelStyle: const TextStyle(color: Colors.blue),
        unselectedIconTheme: const IconThemeData(
          color: Color(0xff4E5152),
        ),
        unselectedLabelStyle: const TextStyle(
          color: Color(0xff4E5152),
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_outlined,
            ),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt,
            ),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.highlight_alt_sharp,
            ),
            label: 'Story',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.groups,
            ),
            label: 'Contacts',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: updateIndex,
      ),
      body: _screens[selectedIndex],
    );
  }
}
