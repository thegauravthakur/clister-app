import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:test_app/customNotifier/customNotifier.dart';
import 'package:test_app/widgets/myListWidgets/customAddButton.dart';
import 'package:test_app/widgets/myListWidgets/customAlertDialog.dart';
import 'package:test_app/widgets/myListWidgets/customCard.dart';
import 'package:test_app/widgets/myListWidgets/customFloatingActionButton.dart';

import './emptyListScreen.dart';
import '../models/inputValues.dart';
import '../storage.dart';

class MyListScreen extends StatefulWidget {
  final Storage space;

  MyListScreen({Key key, @required this.space}) : super(key: key);

  @override
  _MyListScreenState createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  List<InputValues> myData = [];
  final nameController = TextEditingController();
  String temp = '';

  @override
  void initState() {
    super.initState();
    widget.space.readCounter().then((String value) {
      temp = value;
      var l1 = temp.split('\n');
      Provider.of<CustomNotifier>(context, listen: false).makeSame(l1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomNotifier>(context);

    final snackBar = SnackBar(
      content: Text('Deleted by mistake?'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    if (provider.myData != myData) provider.myData = myData;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          CustomFloatingActionButton(nameController: nameController),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'MY LIST',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          CustomAddButton(
            nameController,
          ),
        ],
      ),
      body: FutureBuilder(
        future: provider.space.readCounter(),
        builder: (BuildContext btx, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return Stack(
              children: <Widget>[
                Container(color: Colors.white),
                Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.teal,
                  ),
                )
              ],
            );
          return provider.myData.length != 0
              ? Container(
                  margin: EdgeInsets.all(5),
                  child: ReorderableListView(
                    onReorder: provider.onReorder,
                    children: List.generate(provider.myData.length, (index) {
                      return Slidable(
                        key: ObjectKey(index),
                        actionExtentRatio: 0.20,
                        actionPane: SlidableDrawerActionPane(),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Edit',
                            color: Colors.grey,
                            icon: Icons.more_horiz,
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    var _myController =
                                        new TextEditingController();
                                    _myController.text =
                                        provider.myData[index].name;
                                    _myController.selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset:
                                            _myController.text.length);
                                    return CustomDialogBox(
                                        _myController, index);
                                  });
                            },
                          ),
                        ],
                        child: CustomCard(index, snackBar),
                      );
                    }).toList(),
                  ),
                )
              : HomeScreenWhenNoTilePresent();
        },
      ),

      //
    );
  }
}
