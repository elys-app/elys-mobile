import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
// bool _connectedStatus = false;

  final Uri _elysURL =
      Uri.parse('https://sidenav.d1afp0rnrtf7z0.amplifyapp.com/login/signin');

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onLogout() async {
    try {
      await Amplify.DataStore.clear();
      await Amplify.DataStore.stop();
      Amplify.Auth.signOut().then((_) {
        Navigator.pushNamed(context, '/');
      });
    } on AuthException catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text('${e.message}'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome To Elys',
          style: GoogleFonts.bellefair(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(
                    left: 30.0, top: 10.0, right: 30.0, bottom: 1.0),
                child: new Image.asset('images/logo-white.png',
                    width: 150, height: 150)),
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, top: 10.0, right: 30.0, bottom: 1.0),
              child: const Text(
                'Looks like you don\'t have a',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, top: 1.0, right: 30.0, bottom: 1.0),
              child: const Text(
                'subscription. To use Elys,',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, top: 1.0, right: 30.0, bottom: 10.0),
              child: const Text(
                'subscribe at',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, top: 10.0, right: 30.0, bottom: 30.0),
              child: TextButton(
                child: Text('Elys Online',
                    style: TextStyle(color: Colors.blue[900], fontSize: 18)),
                onPressed: () {
                  launchUrl(_elysURL);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: _onLogout,
                child: Text(
                  'Back to Login',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
