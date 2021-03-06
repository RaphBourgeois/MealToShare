import 'package:flutter/material.dart';
import 'pages/dashboard.dart';
import 'pages/account.dart';
import 'pages/test_page.dart';
import 'pages/cooking_circles.dart';
import 'utils/page_scaffold.dart';

import 'utils/firebaseAPI.dart';

void main(){
  runApp(
    new MaterialApp(
      theme: _themeData,
      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the FirstScreen Widget
        '/': (context) => new Root(),
        // When we navigate to the "/second" route, build the SecondScreen Widget
        '/dashboard': (context) => new MyScaffold().displayPage(context, Dashboard()),
        '/test_page': (context) => new MyScaffold().displayPage(context, TestPage()),
        '/account': (context) => new MyScaffold().displayPage(context, Account()),
        '/cooking_circles': (context) => new MyScaffold().displayPage(context, Groups()),
      },
    )
  );
}

final ThemeData _themeData = new ThemeData(brightness: Brightness.dark);
      
class Root extends StatelessWidget {
  // This widget is the root of your application.
  final String appTitle = 'Meal To Share';
  
  @override
  Widget build(BuildContext context) {
    Connect _connection = new Connect();
    _connection.getConnect().signIn();
    return new MyScaffold().displayPage(context, Groups());
  }
}