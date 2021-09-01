import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
// bool _connectedStatus = false;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    final ButtonStyle registerStyle = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20), primary: Colors.lightBlue);

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
              child: const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: 'User ID',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
              child: const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.visibility),
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
              child: const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                ),
              ),
            ),
            ElevatedButton(
              style: style,
              onPressed: null,
              child: const Text('Register'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
