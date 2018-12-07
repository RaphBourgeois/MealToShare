import 'package:flutter/material.dart';
import '../utils/firebaseAPI.dart';


class Account extends StatefulWidget {
  Account({Key key, this.title}) : super(key: key);
  final String title;
  
  @override
  _AccountState createState() => new _AccountState();
}

class _AccountState extends State<Account> {
  LocalData localData = new LocalData();
  String _name = "";
  Connect connection = new Connect();

  _AccountState() {
    print("Account first print");
    if(_name == ""){
    localData.getUserPref("name").then(
      (val) => setState(() {
          _name = val;

        })
      );
    }
  }


  @override
  Widget build(BuildContext context){

    return new Column(//page
      children: <Widget>[
        new Row(// pictures and Name/Lastname
          children: <Widget>[
            new Expanded(
              child: new FittedBox(
                fit: BoxFit.contain, // otherwise the logo will be tiny
                child: new Container(
                  padding: new EdgeInsets.all(50.0),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                fit: BoxFit.fitWidth,
                alignment: FractionalOffset.topCenter,
                image: new NetworkImage('https://lh3.googleusercontent.com/-kMzSW0CaVXU/AAAAAAAAAAI/AAAAAAAAAAA/APUIFaPEOnYS6q6Lobpiw7uKowhRyWadsg/s96-c/photo.jpg'),
              ),
                    borderRadius: new BorderRadius.circular(250.0),
                    border: null,
                    color: Colors.blueAccent,
                    ),
                    child:null
                  )
                )
              ),
            new Expanded(
              child: new Column(
                children: <Widget>[
                  new TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: _name
                    ),
                  ),
                  new Form(
                    child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Please enter your Lastname'
                    ),
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
        new Container(
          color:Colors.greenAccent,
          child: Row(//food restrictions
            children: <Widget>[
              new Flexible(//resctictions list
                child:new Column(
                  children: <Widget>[
                    new Text('Ingredient to exclude from diet:'),
                    new TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Please enter your name'
                      )
                    )
                  ]
                )
              ),
              new RaisedButton(
                child: const Text('Select existing Restrictions'),
                color: Theme.of(context).accentColor,
                elevation: 4.0,
                splashColor: Colors.blueGrey,
                onPressed: () {
                  //connection.addRestriction("Banana");
                },
              ),
              new RaisedButton(
                child: const Text('Create Restrictions'),
                color: Theme.of(context).accentColor,
                elevation: 4.0,
                splashColor: Colors.blueGrey,
                onPressed: () {
                  //connection.addRestriction("Banana");
                },
              ),
            ],
          )
        )
      ],
    );
  }
}