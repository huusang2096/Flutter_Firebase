import 'package:flutter/material.dart';
import 'package:flutter_app_chat/screens/authenticate/register.dart';
import 'package:flutter_app_chat/screens/authenticate/sign_in.dart';
import 'package:flutter_app_chat/screens/home/home.dart';
import 'package:flutter_app_chat/screens/wrapper.dart';

final Map<String,WidgetBuilder> routes ={
  Home.routeName : (context) => Home(),
  SignIn.routeName : (context) => SignIn(),
  Register.routeName : (context) => Register(),
  Wrapper.routeName : (context) => Wrapper(),
};