import 'package:flutter/material.dart';
class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DashboardState createState() => new _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context){
    return new Container(
      color: Colors.grey,
      child: new InkWell(
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Material(
                color: Colors.orange,
                child: new Column(
                  children: <Widget> [new Expanded(child:new Container(
                    color: Colors.greenAccent,
                    child: new Center(child:new Text('welcome USER, '))
                  )),
                  new Text('toto'),
                  new Expanded(child:new Container(
                    color: Colors.greenAccent,
                    child: new Text('welcome USER, ')
                  )),
                  new Container(
                    color: Colors.cyan,
                    child:Text('tata')),
                  new RaisedButton(
                    child: Text('Launch screen'),
                    onPressed: () {
                      // Navigate to the second screen using a named route
                      Navigator.pushNamed(context, '/test_page');
                    },
                  ),
                  ]
                )
              )
            )

          ]
        )
      )
    );
  }
}