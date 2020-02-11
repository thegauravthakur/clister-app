import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/customNotifier/customNotifier.dart';

class CustomAddButton extends StatelessWidget {
  final _nameController;

  CustomAddButton(this._nameController);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomNotifier>(context);
    return Container(
      margin: EdgeInsets.only(right: 1),
      child: IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          provider.showBottomSheet(context, _nameController, context);
        },
      ),
    );
  }
}
