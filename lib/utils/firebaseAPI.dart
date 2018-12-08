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

  Future<SharedPreferences> getGroups() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}




abstract class Connector{
  bool connected = false;
  String _userName ="default";
  Map<String,Map<String,String>> _groups;
  LocalData localData = new LocalData();

  bool signIn(){return false;}
  

  String getUserName(){
    if (_userName == null){
      signIn();
    }
    return _userName;
  }

  void signOut();

  void setGroups();
  void addRestriction(String restriction);
  void addData();
  Map<String,Map<String,String>> getGroups(){return _groups;}

}
class Connect{
  Connector _connect = new ConnectLocal();
  Connector getConnect(){
    return _connect;
  }
}
class ConnectLocal extends Connector{
  String _userName ="defaultLocal";
  bool connected = false;

  bool init(){
    _groups =  <String,Map<String,String>>{
      "g1": <String,String>{
        "name": "Hell Default Kitchen",
        "location": "Willis Basement",
        "max": "2",
      },
    };
    return true;
  }
  ConnectLocal(){
    //init();
    setGroups();
  }

  bool signIn(){
    connected = true;
    _userName = "FakeConnectedUser";
    return false;
  }
  void signOut(){
    connected = false;
    _userName ="none";
    print("User signed out");
  }
  void addRestriction(String restriction){print("addRestriction not implemented");}
  void setGroups(){
    init();
    _groups["g2"] =<String,String>{
      "name": "Hell Local Kitchen",
      "location": "Willis Basement",
      "max": "3",
    };
    print("Groups: " + _groups.toString());
  }
  void addData(){print("addData not implemented");}
}
class ConnectFireBase extends Connector{
  String _userName ="defaultFB";
  bool connected = false;

  bool signIn(){
    signInAsync();
    return false;
  }
  Future<FirebaseUser> signInAsync() async{
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

  final DocumentReference documentReference = Firestore.instance.document("mealtoshare.demo/restrictions");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  LocalData localData = new LocalData();

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

  void setGroups(){
    Map<String,String> data = <String,String>{
      "name": "Hell Kitchen 3",
      "location": "Willis Tower",
      "max:": "5",
    };
    
    //documentReference.get();
    Firestore.instance.document("mealtoshare.demo/Groups").setData(data).whenComplete((){
      print("Groups: " + 'Groups');
    }).catchError((e) => print(e));
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

