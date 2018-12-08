import 'package:flutter/material.dart';
import '../utils/firebaseAPI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/page_scaffold.dart';

class TestPage extends StatefulWidget {
  TestPage({Key key, this.title}) : super(key: key);
  final String title;

  
  
   
  @override
  _TestPage createState() => new _TestPage();
}

class _TestPage extends State<TestPage> {
  Connect _connection = new Connect();
  @override
  Widget build(BuildContext context){
    return new Column(children: <Widget>[
        new RaisedButton(
          child: const Text('Test Connect'),
          color: Theme.of(context).accentColor,
          elevation: 4.0,
          splashColor: Colors.blueGrey,
          onPressed: () {
            //_connection.signIn().then((FirebaseUser user)=>print(user)).catchError((e)=>print(e));
            _connection.getConnect().signIn();
          },
        ),
        new RaisedButton(
          child: const Text('Test Signout'),
          color: Theme.of(context).accentColor,
          elevation: 4.0,
          splashColor: Colors.blueGrey,
          onPressed: () {
            _connection.getConnect().signOut();
          },
        ),
        new RaisedButton(
          child: const Text('Test setGroups()'),
          color: Theme.of(context).accentColor,
          elevation: 4.0,
          splashColor: Colors.blueGrey,
          onPressed: () {
            _connection.getConnect().setGroups();
          },
        )
      ],)
    ;
  }
}

