import 'package:daily_life/main.dart';
import 'package:daily_life/modules/Auth/views/index.dart';
import 'package:daily_life/modules/Credit/views/index.dart';
import 'package:daily_life/modules/Credit/views/form.dart';
import 'package:daily_life/modules/Income/views/index.dart';
import 'package:daily_life/modules/Income/views/form.dart';
import 'package:daily_life/modules/dahboard/views/index.dart';
import 'package:daily_life/modules/settings/views/index.dart';
import 'package:daily_life/modules/spending/views/index.dart';
import 'package:daily_life/modules/spending/views/form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    final args = setting.arguments;

    switch (setting.name) {
      case '/':
        if (args is User) {
          return MaterialPageRoute(
            builder: (_) => MainScreen(
              user: args,
            ),
          );
        }
        return _errorRoute();
      case '/auth':
        return MaterialPageRoute(builder: (_) => Auth());
      case '/credit':
        return MaterialPageRoute(builder: (_) => Credit());
      case '/credit/add':
        return MaterialPageRoute(builder: (_) => CreditForm());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());
      case '/income':
        return MaterialPageRoute(builder: (_) => Income());
      case '/income/add':
        return MaterialPageRoute(builder: (_) => IncomeForm());
      case '/settings':
        return MaterialPageRoute(builder: (_) => Settings());
      case '/spending':
        return MaterialPageRoute(builder: (_) => Spending());
      case '/spending/add':
        return MaterialPageRoute(builder: (_) => SpendingForm());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("Error Route."),
        ),
      );
    });
  }
}
