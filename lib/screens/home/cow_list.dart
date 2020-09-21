import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/screens/home/cow_tile.dart';
import 'package:flutter_app_chat/screens/models/cow.dart';
import 'package:provider/provider.dart';

class CowList extends StatefulWidget {
  @override
  _CowListState createState() => _CowListState();
}

class _CowListState extends State<CowList> {
  @override
  Widget build(BuildContext context) {

    final cows = Provider.of<List<Cow>>(context);

    try{
      cows.forEach((cow) {
        print(cow.name);
        print(cow.milk);
        print(cow.strength);
      });
    }catch (e){
      print(e.toString());
    }

    return ListView.builder(
      itemCount: cows.length,
      itemBuilder: (context,index){
        return CowTile(cow: cows[index]);
      },
    );
  }
}
