import 'package:flutter/material.dart';
import '../pages/left_menu.dart';

class MyScaffold{
  // This widget is the root of your application.
  final String appTitle = 'Meal To Share';
  Widget displayPage(BuildContext context, Widget page) {
    return new MaterialApp(
      title: appTitle,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(appTitle),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.account_circle),
              tooltip: 'My Account',
              onPressed: null,
            ),
          ],
        ),
        drawer: new Drawer(child:leftMenu(context)),
        body: page,
        // This trailing comma makes auto-formatting nicer for build methods.   
      ),
    );
  }
}