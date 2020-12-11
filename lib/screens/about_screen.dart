import 'package:flutter/material.dart';
import 'package:phnauthnew/views/homepage.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "About",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "Team",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.home),onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => HomePage()
            ));
          },),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Text('This a news application which has additional features like calendar search'),
          Text('To contact development team contact us')
        ],
      ),
    );
  }
}
