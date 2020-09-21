import 'package:flutter/material.dart';
import 'package:flutter_app_chat/screens/models/cow.dart';

class CowTile extends StatelessWidget {

  final Cow cow;

  CowTile({this.cow});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[cow.strength],
          ),
          title: Text(cow.name),
          subtitle: Text("Take ${cow.milk} milk(s)."),
        ),
      ),
    );
  }
}
