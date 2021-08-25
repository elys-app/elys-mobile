import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(ElysApp());
}

class ElysApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
      ),
      home: LoginPage(title: 'Welcome to ELYS'),
    );
  }
}
