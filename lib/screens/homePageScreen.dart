import 'package:flutter/material.dart';
import 'package:test_app/screens/myListScreen.dart';
import 'package:test_app/screens/reminderScreen.dart';
import 'package:test_app/screens/settingsScreen.dart';

import '../storage.dart';

class HomePageScreen extends StatefulWidget {
  final appBar;

  HomePageScreen({this.appBar});
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int selectedIndex = 0;
  final widgetOptions = [
    MyListScreen(space: Storage()),
    ReminderScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('My List')),
          BottomNavigationBarItem(
              icon: Icon(Icons.timer), title: Text('My Reminders')),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text('Settings')),
        ],
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        fixedColor: Colors.teal[800],
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
