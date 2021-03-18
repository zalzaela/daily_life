import 'package:daily_life/modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _email;
  TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationFailiure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            buildWhen: (current, next) {
              if (next is AuthenticationSuccess) {
                return false;
              }
              return true;
            },
            builder: (context, state) {
              if (state is AuthenticationInitial ||
                  state is AuthenticationFailiure) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  padding: EdgeInsets.only(bottom: 100),
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 3 / 3.9,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(79),
                              bottomLeft: Radius.circular(79),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 290,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: TextField(
                                  controller: _email,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                              Container(
                                width: 290,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  borderRadius: BorderRadius.circular(57),
                                ),
                                child: TextField(
                                  controller: _password,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Don\'t have an account? '),
                                  GestureDetector(
                                    onTap: () {
                                      print('Sign Up');
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 60),
                              TextButton(
                                onPressed: () {
                                  print('Login');
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(57),
                                      side: BorderSide(
                                          color: Colors.blue, width: 5),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 100)),
                                ),
                                child: Text(
                                  'Log in',
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                              SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        BlocProvider.of<AuthenticationBloc>(
                                                context)
                                            .add(AuthenticationGoogleStarted()),
                                    child: FaIcon(
                                      FontAwesomeIcons.google,
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(width: 45),
                                  GestureDetector(
                                    onTap: () {
                                      print('Facebook');
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.facebookF,
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(width: 45),
                                  GestureDetector(
                                    onTap: () {
                                      print('Twitter');
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.twitter,
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is AuthenticationLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Center(
                  child: Text('Undefined state : ${state.runtimeType}'));
            },
          );
        },
      ),
    );
  }
}
