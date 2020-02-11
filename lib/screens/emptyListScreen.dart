import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:test_app/customNotifier/customNotifier.dart';

class HomeScreenWhenNoTilePresent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomNotifier>(context);
    final mediaQuery = MediaQuery.of(context);
    final deviceWidth = mediaQuery.size.width;
    return Column(
      children: <Widget>[
        SizedBox(
          height: deviceWidth * 0.50,
        ),
        SvgPicture.asset(
          provider.darkTheme
              ? 'images/emptyBlack.svg'
              : 'images/remptyTeal.svg',
          width: deviceWidth * 0.40,
        ),
        SizedBox(
          height: 30,
        ),
        Center(
            child: Text(
          'No Item Found',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Lato',
            fontSize: 20,
          ),
        )),
        Center(
            child: Text(
          'Click on add button to create your list',
          style: TextStyle(
            color: Colors.black,
          ),
        ))
      ],
    );
  }
}
