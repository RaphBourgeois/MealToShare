import 'package:flutter/material.dart';
import '../pages/test_page.dart';

Widget leftMenu(BuildContext context){ 
  return new ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
    leftMenuHeader(),
    leftMenuItem(context,'Cooking Groups','/dashboard'),
    leftMenuItem(context,'Test Page','/test_page'),
    leftMenuItem(context,'My Account','/account')
  ],
  ); 
}

Widget leftMenuHeader(){
  return new DrawerHeader(
    decoration: BoxDecoration(
          color: Colors.blue,
    ),
    child: new Center(child:Text('drawerheader', style: new TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold)))
  );
} 

Widget leftMenuItem(BuildContext context, String name, String page){
  return new ListTile(
    leading: new Icon(Icons.group, color: Colors.grey,),
    title: new Text(name, style: new TextStyle(color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.bold),),
    onTap: () {
      // change app state...
      print('tapped');
      Navigator.pushNamed(context,page);
       // close the drawer
    },
  );
} 