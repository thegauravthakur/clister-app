import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/models/inputValues.dart';

class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/my_special_list.txt');
  }

  Future<File> get _deviceTheme async {
    final path = await _localPath;
    return File('$path/theme.txt');
  }

  Future<String> readTheme() async {
    try {
      final file = await _deviceTheme;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 'empty';
    }
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 'error';
    }
  }

  Future<File> writeCounter(String counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter', mode: FileMode.append);
  }

  Future<void> writeToFile(int index, InputValues inputValues) async {
    final correctIndex = index * 2;

    final file = _localFile;
    file.then((value) {
      value.readAsLines().then((List<String> lines) {
        for (int i = 0; i < lines.length; i++) {
          if (lines[i] == '') lines.removeAt(i);
        }
        lines.insert(correctIndex, inputValues.time);
        lines.insert(correctIndex, inputValues.name);

        final newTextData = lines.join('\n');
        lines.length > 0
            ? value.writeAsString(newTextData + '\n')
            : value.writeAsString(newTextData);
      });
    });
  }

  Future<File> writeTheme(String theme) async {
    final file = await _deviceTheme;

    // Write the file
    return file.writeAsString('$theme', mode: FileMode.write);
  }

  Future<void> myAsyncFunction(int index) async {
    final correctIndex = index * 2;

    final file = _localFile;
    file.then((value) {
      value.readAsLines().then((List<String> lines) {
        for (int i = 0; i < lines.length; i++) {
          if (lines[i] == '') lines.removeAt(i);
        }
        lines.removeAt(correctIndex);
        lines.removeAt(correctIndex);
        final newTextData = lines.join('\n');
        lines.length > 0
            ? value.writeAsString(newTextData + '\n')
            : value.writeAsString(newTextData);
      });
    });
  }

  Future<void> onScroll(int oldIndex, int newIndex) async {
    final correctIndex = oldIndex * 2;
    final file = _localFile;
    file.then((value) {
      value.readAsLines().then((List<String> lines) {
        final line1 = lines[correctIndex];
        lines.removeAt(correctIndex);
        final line2 = lines[correctIndex];
        lines.removeAt(correctIndex);
        lines.insert(newIndex * 2, line2);
        lines.insert(newIndex * 2, line1);
        final newTextData = lines.join('\n');
        lines.length > 0
            ? value.writeAsString(newTextData + '\n')
            : value.writeAsString(newTextData);
      });
    });
  }

  Future<void> chnageName(int index, String data) async {
    final correctIndex = index * 2;
    final file = _localFile;
    file.then((value) {
      value.readAsLines().then((List<String> lines) {
        lines[correctIndex] = data;
        final newTextData = lines.join('\n');
        lines.length > 0
            ? value.writeAsString(newTextData + '\n')
            : value.writeAsString(newTextData);
      });
    });
  }
}
