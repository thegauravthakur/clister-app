import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/customNotifier/customNotifier.dart';

class CustomDialogBox extends StatelessWidget {
  final _myController;
  final _index;
  CustomDialogBox(this._myController, this._index);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomNotifier>(context);
    return AlertDialog(
      backgroundColor: provider.darkTheme ? Colors.grey[900] : Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(
        'Enter the new name',
        style: TextStyle(
          fontSize: 20,
          color: Colors.teal,
        ),
      ),
      content: TextFormField(
        style: TextStyle(
            color: provider.darkTheme ? Colors.teal[900] : Colors.black),
        autofocus: true,
        controller: _myController,
        decoration: InputDecoration(
            hintText: "New Name",
            hintStyle: TextStyle(
                color: provider.darkTheme ? Colors.white60 : Colors.black)),
      ),
      actions: <Widget>[
        FlatButton(
          child: new Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Submit'),
          onPressed: () {
            provider.alertBox(_myController, _index);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
