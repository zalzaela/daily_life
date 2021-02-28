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
        color: Colors.grey[600],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: TextButton(
                child: Text("Sign With Google"),
                onPressed: () {
                  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
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
