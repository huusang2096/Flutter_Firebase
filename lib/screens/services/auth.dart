import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_chat/screens/models/user.dart';
import 'package:flutter_app_chat/screens/services/database.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //create user object base on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null ;
  }

  //auth change user stream
  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async{
    try{
      AuthResult result = await _firebaseAuth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch (e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future<FirebaseUser> signInWithEmailAndPassword(String email,String pass) async{
    String errorMessage;
    try{
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      print("===> 1: "+ user.uid);
      return user;
    }catch(e){
      switch( e.code){
        case "ERROR_INVALID_EMAIL" :
          errorMessage = " your email address appears to be malformed";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage ="your password is wrong";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage ="User with this email doesn't exist";
          break;
          //more more more solution ERROR....
      }
      if(errorMessage != null){
        return Future.error(errorMessage);
      }
    }
  }

  //register email & password
  Future registerEmailAndPassword(String email,String pass) async{
    try{
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user =result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('0','new milk member',100);
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _firebaseAuth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}