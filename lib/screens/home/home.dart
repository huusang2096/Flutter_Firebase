import 'package:flutter/material.dart';
import 'package:flutter_app_chat/screens/authenticate/sign_in.dart';
import 'package:flutter_app_chat/screens/services/auth.dart';

class Home extends StatelessWidget {
  static String routeName = "/home";
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text("App Orange"),
        backgroundColor: Colors.orange[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async{
              await _authService.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(SignIn.routeName, (route) => false);
            },
            icon: Icon(Icons.person),
            label: Text("Log out"),
          ),
        ],
      ),
    );
  }
}
