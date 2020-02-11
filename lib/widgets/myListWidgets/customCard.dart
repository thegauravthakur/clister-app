import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_app/customNotifier/customNotifier.dart';
import 'package:test_app/models/deletedModel.dart';
import 'package:test_app/storage.dart';

class CustomCard extends StatelessWidget {
  final snackBar;
  final index;

  CustomCard(this.index, this.snackBar);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomNotifier>(context);
    return Card(
      color: provider.darkTheme ? Colors.grey[900] : Colors.white,
      key: ObjectKey(index),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Text(
                  '${index + 1}    ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 20),
                ),
              ),
              flex: 0,
            ),
            Expanded(
              flex: 9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      provider.myData[index].name,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.teal[900],
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                        DateFormat.jm().format(
                            DateTime.parse(provider.myData[index].time)),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[900],
                        )),
                  )
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    final deletedModel =
                        new DeletedModel(index, provider.myData[index]);
                    provider.removeListItem(index);
                    provider.space.myAsyncFunction(index);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('Removed by mistake?'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          provider.addToListWithIndex(
                              deletedModel.getIndex, deletedModel.getValue);
                          Storage().writeToFile(
                              deletedModel.getIndex, deletedModel.getValue);
                          // Some code to undo the change.
                        },
                      ),
                    ));
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.blueAccent,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
