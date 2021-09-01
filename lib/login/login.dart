import 'package:flutter/material.dart';
import 'register.dart';
import 'password.dart';

import '../dashboard.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // bool _connectedStatus = false;

  String userName = '';
  String password = '';

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

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
            Text('New to Elys?',
                style: TextStyle(color: Colors.lightBlue, fontSize: 30)),
            ElevatedButton(
              style: registerStyle,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RegisterPage(title: 'Register for ELYS')));
              },
              child: const Text('Sign Up Here'),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
              child: TextField(
                controller: userNameController,
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
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.visibility),
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
              style: style,
              onPressed: () {
                setState(() {
                  userName = userNameController.text;
                  password = passwordController.text;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
              },
              child: const Text('Login'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PasswordPage(title: 'Lost Password'),
                        ),
                    );
              },
              child: const Text('Forgot Password?'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
