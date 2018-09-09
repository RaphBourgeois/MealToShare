import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData{
  List<String> personalRestrictions;
   setUserPref(String key, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, name);
    print('set LocalData: ' + key+':'+name);
  }

  Future<String> getUserPref(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
  }
  Future<SharedPreferences> getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}


class Connect{
  final DocumentReference documentReference = Firestore.instance.document("mealtoshare.demo/restrictions");

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  String _userName;

  LocalData localData = new LocalData();

  Future<FirebaseUser> signIn() async{
    GoogleSignInAccount googleSingInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSingInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
      idToken: gSA.idToken, accessToken: gSA.accessToken);
      _userName = user.displayName;
      localData.setUserPref('name', _userName);
      print("User Name : ${user.displayName}");
      print("User Name : ${user.photoUrl}");
      return user;
  } 

  String getUserName(){
    if (_userName == null){
      signIn();
    }
    return _userName;
  }

  void signOut(){
    googleSignIn.signOut();
    print("User signed out");
  }

  void addRestriction(String restriction){
    Map<String,String> data = <String,String>{
      "restriction": restriction
    };
    documentReference.setData(data).whenComplete((){
      print("restriction: " + restriction);
    }).catchError((e) => print(e));
  }

  void addData(){
    Map<String,String> data = <String,String>{
      "name": "Raph B",
      "desc": "quick test with firebase"
    };
    documentReference.setData(data).whenComplete((){
      print("data added");
    }).catchError((e) => print(e));
  }
}

