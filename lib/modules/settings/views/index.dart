import 'dart:ui';

import 'package:daily_life/modules/Auth/config/google_sign_in.dart';
import 'package:daily_life/modules/Auth/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.grey[100],
          ),
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.fromLTRB(15, 50, 15, 15),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profile",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                  fontFamily: "Roboto-Thin",
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      user.photoURL,
                      height: 50.0,
                      width: 50.0,
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 25,
                          fontFamily: "Roboto-Light",
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        user.email,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "Roboto-Light",
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: Colors.grey[100],
          ),
          padding: EdgeInsets.only(left: 15, top: 15, bottom: 5),
          margin: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          width: MediaQuery.of(context).size.width,
          child: Text(
            "Settings",
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontFamily: "Roboto-Thin",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 510,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            color: Colors.grey[100],
          ),
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          margin: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              buildListSettingItem(FontAwesomeIcons.wallet, "Account"),
              buildListSettingItem(FontAwesomeIcons.columns, "Category"),
              buildListSettingItem(FontAwesomeIcons.chartBar, "Statistics"),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: Text(
                  "Log Out",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: "Roboto-Thin",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                  // Navigator.of(context).pushNamed('/auth');
                  if (provider.isSigningIn) {
                    return buildLoading();
                  } else {
                    return Login();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );

     
  }
  Widget buildLoading() => Center(child: CircularProgressIndicator());
  Widget buildListSettingItem(IconData icon, String name) {
    return GestureDetector(
      onTap: () {
        debugPrint('Settings: $name');
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  FaIcon(
                    icon,
                    color: Colors.grey[600],
                  ),
                  SizedBox(width: 10),
                  Text(
                    name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontFamily: "Roboto-Thin",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.grey[400],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
