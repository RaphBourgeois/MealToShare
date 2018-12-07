import 'package:flutter/material.dart';
import '../utils/firebaseAPI.dart';

class Groups extends StatefulWidget {
  Groups({Key key, this.title}) : super(key: key);
  final String title;
  
  @override
  _GroupsState createState() => new _GroupsState();
}

class _GroupsState extends State<Groups> {
  LocalData localData = new LocalData();
  Connect connection = new Connect();

  String _name = "";
  _GroupsState() {
    //connection..

    if(_name == "" && false){
    localData.getUserPref("name").then(
      (val) => setState(() {
          _name = val +"was here";

        })
      );
    }
  }
  Widget multiListDisplay(){
    final int column =3;
    final int row =10;


    List<Widget> listMyWidgets() {
      List<Widget> list = new List();
      list.add(new Row(children: <Widget>[new Text("Name"),new Text("Location"),new Text("# members"),]));
      int i=0;
      while(i < row){
        list.add(new Row(children: <Widget>[new Text("Hell Kitchen",style: Theme.of(context).textTheme.title,),new Text("Willis Tower"),new Text("3/5"),]));
        i++;
      }
      return list;
    }

    return new Container(
      child: new Column(//multi list display widget
          children: listMyWidgets(),
      )
    );
  }

  @override
  Widget build(BuildContext context){
    return new Column(//page
      children: <Widget>[
        new Text("You are not part of any group."),
        multiListDisplay(),
      ],
    );
  }
}