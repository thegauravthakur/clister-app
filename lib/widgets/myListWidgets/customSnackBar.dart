import 'package:flutter/material.dart';
import 'package:test_app/models/deletedModel.dart';

class CustomSnackBar extends StatelessWidget {
  final deletedModel;

  CustomSnackBar(this.deletedModel);
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
  }
}
