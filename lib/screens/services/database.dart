import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_chat/screens/models/cow.dart';
import 'package:flutter_app_chat/screens/models/user.dart';

class DatabaseService{
  //collection reference
  final CollectionReference cowCollection = Firestore.instance.collection('cows');
  final String uid;

  DatabaseService({this.uid});


  Future updateUserData(String milks,String name,int strength) async{
    return await cowCollection.document(uid).setData({
      'milk':milks,
      'name' : name,
      'strength': strength,
    });
  }

  //cow list from snapshot
  List<Cow> _cowListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Cow(
        name: doc.data['name'] ?? '',
        milk: doc.data['milk'] ?? '0',
        strength: doc.data['strength'] ?? 0,
      );
    }).toList();
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      milk: snapshot.data['milk'],
      strength: snapshot.data['strength'],
    );
  }

  //get milks stream
  Stream<List<Cow>> get cows {
    return cowCollection.snapshots().map(_cowListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData{
    return cowCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

}