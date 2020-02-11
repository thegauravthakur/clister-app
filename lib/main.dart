import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/screens/homePageScreen.dart';
import 'customNotifier/customNotifier.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider<CustomNotifier>(
        create: (_) => CustomNotifier(),
      ),
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        unselectedWidgetColor: Colors.teal,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.white,
        ),
        primarySwatch: Colors.teal,
        accentColor: Colors.blueAccent,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePageScreen(),
    );
  }
}
