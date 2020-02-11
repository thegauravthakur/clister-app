import 'package:flutter/material.dart';

import '../storage.dart';

class SettingsScreen extends StatelessWidget {
  final space = new Storage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('SETTINGS'),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: Center(
          child: Text('customizations adding soon!'),
        ));
  }
}
