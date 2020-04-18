import 'package:flutter/material.dart';
import 'navigation.dart';
import 'login_email.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Porsio",
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        primaryColorDark: Colors.deepPurple[900],
        primaryColorLight: Colors.deepPurple[100],
        accentColor: Colors.orange[300]
      ),
      debugShowCheckedModeBanner: false,
      home: //MainScreen(),
      Navigation(),
    );
  }
}
