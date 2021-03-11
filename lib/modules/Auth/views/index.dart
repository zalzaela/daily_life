import 'package:daily_life/main.dart';
import 'package:daily_life/modules/Auth/config/google_sign_in.dart';
import 'package:daily_life/modules/Auth/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (contex) => GoogleSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final profider = Provider.of<GoogleSignInProvider>(context);
            var user = FirebaseAuth.instance.currentUser;
            if(profider.isSigningIn) {
              return buildLoading();
            } else if(snapshot.hasData) {
              return MainScreen(user: user);
            } else {
              return Login();
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() => Center(child: CircularProgressIndicator());
}
