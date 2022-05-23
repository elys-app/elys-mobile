import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import '../amplifyconfiguration.dart';

import '../models/ModelProvider.dart';

import 'password.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = true;

  String userName = '';
  String password = '';

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initAmplify();

    _showPassword = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _initAmplify() async {
    final auth = AmplifyAuthCognito();
    final analytics = AmplifyAnalyticsPinpoint();
    final api = AmplifyAPI();
    final storage = AmplifyStorageS3();

    final provider = new ModelProvider();
    final dataStore = AmplifyDataStore(modelProvider: provider);

    try {
      if (!Amplify.isConfigured) {
        Amplify.addPlugins([auth, analytics, api, storage, dataStore]);
        await Amplify.configure(amplifyconfig);
      }
    } catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _load(String destination) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        userName = userNameController.text;
        password = passwordController.text;
      });
      try {
        await Amplify.Auth.signOut();
        await Amplify.Auth.signIn(username: userName, password: password);
        Navigator.pushNamed(context, '/loading', arguments: destination);
      } on UserNotFoundException catch (e) {
        Amplify.Auth.signOut();
        SnackBar snackBar = SnackBar(
          content: Text('${e.message}'),
          duration: Duration(seconds: 3),
          action: SnackBarAction(label: 'OK', onPressed: () {}),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } on NotAuthorizedException catch (e) {
        SnackBar snackBar = SnackBar(
          content: Text('Wrong User ID or Password'),
          duration: Duration(seconds: 3),
          action: SnackBarAction(label: 'OK', onPressed: () {}),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(e);
      }
    }
  }

  Future<void> _onLoginPressed() async {
    _load('main');
  }

  Future<void> _onGoToPanicPage() async {
    _load('panic');
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, top: 10.0, right: 30.0),
                  child: new Image.asset('images/logo-black.png',
                      width: 150, height: 150)),
              Padding(
                padding: EdgeInsets.only(
                    left: 30.0, top: 5.0, right: 30.0, bottom: 20.0),
                child: Text('Welcome to Elsy Mobile',
                    style: GoogleFonts.bellefair(
                        textStyle: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 34,
                            fontWeight: FontWeight.w500))),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your User Name';
                    }
                    return null;
                  },
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
                    left: 30.0, top: 10.0, right: 30.0, bottom: 30.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: _showPassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    prefixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility_off : Icons.visibility,
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
                onLongPress: _onGoToPanicPage,
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
              Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, top: 10.0, right: 30.0, bottom: 5.0),
                  child: Center(
                    child:
                        Text('v0.8.7 Build 19', style: TextStyle(fontSize: 14)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
