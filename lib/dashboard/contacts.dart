import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'Contacts Page',
              style: TextStyle(color: Colors.lightBlue, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
