import 'package:flutter/material.dart';
import 'package:flutter_app_chat/routes.dart';
import 'package:flutter_app_chat/screens/authenticate/sign_in.dart';
import 'package:flutter_app_chat/screens/models/user.dart';
import 'package:flutter_app_chat/screens/services/auth.dart';
import 'package:flutter_app_chat/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        //home: Wrapper(),
        debugShowCheckedModeBanner: false,
        initialRoute: Wrapper.routeName,
        routes: routes,
      ),
    );
  }
}

