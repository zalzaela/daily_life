import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class SettingView extends StatelessWidget {
  SettingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            Navigator.pushNamed(context, '/account');
          },
          child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.fromLTRB(20, 7, 20, 7),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.blue[300], spreadRadius: 3),
              ],
            ),
            child: Center(
              child: Text('Account'),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/category');
          },
          child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.fromLTRB(20, 7, 20, 7),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.blue[300], spreadRadius: 3),
              ],
            ),
            child: Center(
              child: Text('Category'),
            ),
          ),
        ),
      ],
    );
  }
}
