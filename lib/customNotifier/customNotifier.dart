import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_modal/rounded_modal.dart';
import 'package:test_app/models/inputValues.dart';

import '../storage.dart';

class CustomNotifier with ChangeNotifier {
  bool darkTheme = false;
  bool once = false;
  final space = new Storage();
  List<InputValues> myData = [];

  void removeListItem(int index) {
    myData.removeAt(index);
    notifyListeners();
  }

  void addToListWithIndex(int index, InputValues values) {
    myData.insert(index, values);
    notifyListeners();
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > myData.length) newIndex = myData.length;
    if (oldIndex < newIndex) newIndex--;
    var item = myData[oldIndex];
    space.onScroll(oldIndex, newIndex);
    myData.removeAt(oldIndex);
    myData.insert(newIndex, item);
    notifyListeners();
  }

  void alertBox(TextEditingController _myController, int index) {
    if (!(_myController.text.length == 0)) {
      myData[index].name = _myController.text;
      space.chnageName(index, _myController.text);
    }
    notifyListeners();
  }

  void makeSame(List<String> temp) {
    for (int i = 0; i < temp.length - 1; i += 2) {
      myData.add(InputValues(temp[i], temp[i + 1]));
      print(temp[i]);
      print(temp[i + 1]);
      notifyListeners();
    }
  }

  void addToList(TextEditingController nameController) {
    if (nameController.text.length != 0) {
      myData.add(InputValues(nameController.text, DateTime.now().toString()));
      space.writeCounter(
          '${nameController.text}\n${DateTime.now().toString()}\n');
    }
    nameController.clear();
    notifyListeners();
  }

  void raisedButtonModelSheet(TextEditingController nameController) {
    if (nameController.text.length != 0) {
      myData.add(InputValues(nameController.text, DateTime.now().toString()));
      space.writeCounter(
          '${nameController.text}\n${DateTime.now().toString()}\n');
    }
    notifyListeners();
  }

  void showBottomSheet(BuildContext ctx, TextEditingController nameController,
      BuildContext context) {
    final provider = Provider.of<CustomNotifier>(context, listen: false);

    showRoundedModalBottomSheet(
        color: provider.darkTheme ? Colors.grey[900] : Colors.white,
        radius: 10,
        context: ctx,
        builder: (BuildContext bctx) {
          return Container(
            margin: EdgeInsets.only(right: 25, left: 25, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  onFieldSubmitted: (value) {
                    addToList(nameController);
                    Navigator.pop(context);
                  },
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.center,
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter the name of item',
                    hintStyle: TextStyle(
                        fontSize: 18,
                        color: provider.darkTheme
                            ? Theme.of(context).primaryColor
                            : Colors.grey[700]),
                  ),
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 20),
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    raisedButtonModelSheet(nameController);
                    nameController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
