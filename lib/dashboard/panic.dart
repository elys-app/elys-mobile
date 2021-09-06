import 'package:flutter/material.dart';

class PanicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'This is the Panic Page',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
      color: Colors.red
    );
  }
}
