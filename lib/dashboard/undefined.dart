import 'package:flutter/material.dart';

class UndefinedView extends StatelessWidget {
  const UndefinedView({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Route for ' + name + 'is not defined', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
