import 'package:daily_life/main.dart';
import 'package:daily_life/modules/auth/views/index.dart';
import 'package:daily_life/modules/credit/views/form.dart';
import 'package:daily_life/modules/credit/views/index.dart';
import 'package:daily_life/modules/income/views/form.dart';
import 'package:daily_life/modules/income/views/index.dart';
import 'package:daily_life/modules/spending/views/form.dart';
import 'package:daily_life/modules/spending/views/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/services.dart';

class Routes {
  static FluroRouter router;
  // Auth
  static Handler _authHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Auth());
  // Dashboard
  static Handler _dashboardHandler =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    var user = FirebaseAuth.instance.currentUser;
    return MainScreen(user: user, page: 2);
  });

  // Income
  static Handler _incomeHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Income());
  static Handler _incomeFromHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          IncomeForm());
  // Spending
  static Handler _spendingHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Spending());
  static Handler _spendingFromHandler =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return SpendingForm(id: params['id'][0]);
  });
  // Credit
  static Handler _creditHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Credit());
  static Handler _creditFormHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          CreditForm());

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "ROUTE WAS NOT FOUND",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                  ),
                  child: Text(
                    "Close App",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
    // Auth
    router.define("/auth", handler: _authHandler);
    // MainScreen
    router.define(
      "/main",
      handler: _dashboardHandler,
      transitionType: TransitionType.material,
    );
    // Income
    router.define("/income", handler: _incomeHandler);
    router.define("/income/form", handler: _incomeFromHandler);
    // Spending
    router.define("/spending", handler: _spendingHandler);
    router.define("/spending/form/:id", handler: _spendingFromHandler);
    // Credit
    router.define("/credit", handler: _creditHandler);
    router.define("/credit/form", handler: _creditFormHandler);
    // router.define(demoSimpleFixedTrans, handler: demoRouteHandler, transitionType: TransitionType.inFromLeft);
  }
}
