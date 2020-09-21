import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/screens/authenticate/sign_in.dart';
import 'package:flutter_app_chat/screens/home/cow_list.dart';
import 'package:flutter_app_chat/screens/home/settings_form.dart';
import 'package:flutter_app_chat/screens/models/cow.dart';
import 'package:flutter_app_chat/screens/services/auth.dart';
import 'package:flutter_app_chat/screens/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static String routeName = "/home";
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding:  EdgeInsets.symmetric(horizontal: 60.0,vertical: 20.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Cow>>.value(
      value:DatabaseService().cows,
      child: Scaffold(
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
            FlatButton.icon(
              onPressed: (){
                _showSettingPanel();
              },
              icon: Icon(Icons.settings),
              label: Text("Settings"),
            ),
          ],
        ),
        body: CowList(),
      ),
    );
  }
}
