import 'package:flutter/material.dart';
import 'package:phnauthnew/screens/registration_screen.dart';
import 'package:phnauthnew/services/authservice.dart';
import 'package:phnauthnew/services/themechanger.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
        defaultBrightness: Brightness.dark,
        builder: (context, _brightness) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
               theme: ThemeData(primarySwatch: Colors.blue, brightness: _brightness),
              home: AuthService().handleAuth()

          );
        }
    );
  }
}

  