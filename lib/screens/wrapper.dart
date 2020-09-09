import 'package:flutter/material.dart';
import 'package:flutter_app_chat/screens/authenticate/authenticate.dart';
import 'package:flutter_app_chat/screens/home/home.dart';
import 'package:flutter_app_chat/screens/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  static String routeName = "/default";
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    //return either Home or Authenticate widget
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
