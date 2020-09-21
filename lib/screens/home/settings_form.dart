import 'package:flutter/material.dart';
import 'package:flutter_app_chat/screens/models/user.dart';
import 'package:flutter_app_chat/screens/services/database.dart';
import 'package:flutter_app_chat/shared/constants.dart';
import 'package:flutter_app_chat/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> milks = ['0','1','2','3','4'];
  //form value
  String _currentName;
  String _currentMilks;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder:(context,snapshot) {

        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Update your milk settings",
                  style: TextStyle(fontSize: 18,),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? "Please enter a name" : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0,),
                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentMilks ?? userData.milk,
                  items: milks.map((milk) {
                    return DropdownMenuItem(
                      value: milk,
                      child: Text("$milk sugars"),
                    );
                  }).toList(),
                  onChanged: (val){
                    setState(() {
                      _currentMilks = val;
                    });
                  },
                ),
                //Slider
                Slider(
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  onChanged: (val){
                    setState(() {
                      _currentStrength = val.round();
                    });
                  },
                ),
                RaisedButton(
                  onPressed: () async {
                    print(_currentName);
                    print(_currentMilks);
                    print(_currentStrength);
                  },
                  color: Colors.pink[400],
                  child: Text("Update",style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          );
        }else{
          return Loading();
        }
      },
    );
  }
}
