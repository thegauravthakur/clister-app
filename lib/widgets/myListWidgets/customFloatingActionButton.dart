import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/customNotifier/customNotifier.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final nameController;

  CustomFloatingActionButton({this.nameController});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomNotifier>(context);
    return FloatingActionButton(
      backgroundColor: provider.darkTheme ? Colors.grey[800] : Colors.teal,
      child: Icon(Icons.add),
      onPressed: () {
        provider.showBottomSheet(context, nameController, context);
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
    );
  }
}
