import 'package:cloud_firestore/cloud_firestore.dart';

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
}