import 'package:daily_life/modules/authentication/models/authentication_detail.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text('Welcome ' + AuthenticationDetail.authenticationDetail.name),
        )
      ],
    );
  }
}
