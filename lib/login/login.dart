import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';

import 'register.dart';
import 'password.dart';

import '../dashboard/dashboard.dart';
import '../amplifyconfiguration.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;

  String userName = '';
  String password = '';

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _showPassword = false;
    _configureAmplify();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _configureAmplify() async {
    final auth = AmplifyAuthCognito();
    final analytics = AmplifyAnalyticsPinpoint();

    try {
      Amplify.addPlugins([auth, analytics]);
      if (!Amplify.isConfigured) {
        await Amplify.configure(amplifyconfig);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> _onLoginPressed() async {
    setState(() {
      userName = userNameController.text;
      password = passwordController.text;
    });
    try {
      await Amplify.Auth.signIn(username: userName, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage(key: Key('1'), username: userName)));
      return 'success';
    } on InvalidStateException catch (e) {
      Amplify.Auth.signOut();
      SnackBar snackBar = SnackBar(
        content: Text('${e.message}'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return 'failed';
    } on NotAuthorizedException catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text('${e.message}'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return 'failed';
    }
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
                obscureText: _showPassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  prefixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: style,
              onPressed: _onLoginPressed,
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
                    builder: (context) => PasswordPage(title: 'Lost Password'),
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
