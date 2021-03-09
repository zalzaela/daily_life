import 'package:daily_life/modules/Auth/config/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                ),
                child: Text(
                  "Sign With Google",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.login();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
