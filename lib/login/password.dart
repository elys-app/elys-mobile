import 'package:flutter/material.dart';

import 'login.dart';

class PasswordPage extends StatefulWidget {
  PasswordPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
// bool _connectedStatus = false;
  bool _codeSent = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Login'),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
              child: TextField(
                enabled: (_codeSent ? false : true),
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  labelText: 'User ID',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
              child: TextField(
                enabled: (_codeSent ? true : false),
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.visibility),
                  border: OutlineInputBorder(),
                  labelText: 'Code',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
              child: TextField(
                enabled: (_codeSent ? true : false),
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.visibility),
                  border: OutlineInputBorder(),
                  labelText: 'New Password',
                ),
              ),
            ),
            Visibility(
              visible: (_codeSent ? false : true),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
                child: ElevatedButton(
                  style: style,
                  onPressed: () {
                    setState(() {
                      _codeSent = true;
                    });
                  },
                  child: Text('Request Code'),
                ),
              ),
            ),
            Visibility(
              visible: (_codeSent ? true : false),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
                child: ElevatedButton(
                  style: style,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LoginPage(title: 'Welcome to ELYS'),
                        ));
                  },
                  child: Text('Send Code and Password'),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
