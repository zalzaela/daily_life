import 'package:daily_life/main.dart';
import 'package:daily_life/modules/Auth/views/index.dart';
import 'package:daily_life/modules/Credit/views/form.dart';
import 'package:daily_life/modules/Credit/views/index.dart';
import 'package:daily_life/modules/Income/views/form.dart';
import 'package:daily_life/modules/Income/views/index.dart';
import 'package:daily_life/modules/spending/views/form.dart';
import 'package:daily_life/modules/spending/views/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

class Routes {
  static FluroRouter router;
  // Auth
  static Handler _authHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Auth());
  // MainScreen
  static Handler _mainScreenHandler =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        var user = FirebaseAuth.instance.currentUser;
    return MainScreen(user: user, page: 1);
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
  static Handler _spendingFromHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          SpendingForm());
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
          child: Center(
            child: Text(
              "ROUTE WAS NOT FOUND !!!",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
      );
    });
    // Auth
    router.define("/auth", handler: _authHandler);
    // MainScreen
    router.define("/main", handler: _mainScreenHandler);
    // Income
    router.define("/income", handler: _incomeHandler);
    router.define("/income/form", handler: _incomeFromHandler);
    // Spending
    router.define("/spending", handler: _spendingHandler);
    router.define("/spending/form", handler: _spendingFromHandler);
    // Credit
    router.define("/credit", handler: _creditHandler);
    router.define("/credit/form", handler: _creditFormHandler);
    // router.define(demoSimpleFixedTrans, handler: demoRouteHandler, transitionType: TransitionType.inFromLeft);
  }
}
