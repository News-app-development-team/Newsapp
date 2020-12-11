import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phnauthnew/services/themechanger.dart';
import 'package:phnauthnew/views/homepage.dart';

class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading:  IconButton(icon: Icon(Icons.home),onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomePage()
          ));
        },),
      ),
      body: Center(
        child: Container(
          child: RaisedButton(child: Text('theme Changer'),onPressed: (){
            ThemeBuilder.of(context).changeTheme();
          },),
        ),
      ),
    );
  }
}
