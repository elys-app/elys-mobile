import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';

import 'login.dart';
import '../dashboard/dashboard.dart';
import '../models/ModelProvider.dart';
import '../amplifyconfiguration.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key, required this.username, required this.password})
      : super(key: key);

  final String username;
  final String password;

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  initState() {
    super.initState();
    _initAmplify();
  }

  Future<void> _initAmplify() async {
    final auth = AmplifyAuthCognito();
    final analytics = AmplifyAnalyticsPinpoint();
    final api = AmplifyAPI();
    final storage = AmplifyStorageS3();

    final provider = new ModelProvider();
    final dataStore =
        AmplifyDataStore(modelProvider: provider, syncInterval: 3);

    try {
      if (!Amplify.isConfigured) {
        Amplify.addPlugins([auth, analytics, api, storage, dataStore]);
        await Amplify.configure(amplifyconfig);
      }
    } catch (e) {
      print(e);
    }

    try {
      if (Amplify.isConfigured) {
        await Amplify.Auth.signIn(
            username: widget.username, password: widget.password);
        await Amplify.DataStore.start();
        print('Ready!');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MainPage(key: Key('1'), username: widget.username)));
      }
    } on InvalidStateException catch (e) {
      Amplify.Auth.signOut();
      SnackBar snackBar = SnackBar(
        content: Text('${e.message}'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginPage(key: Key('1'), title: 'Welcome to ELYS')));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on NotAuthorizedException catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text('${e.message}'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginPage(key: Key('1'), title: 'Welcome to ELYS')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Loading ELYS',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: SpinKitThreeBounce(
          color: Colors.lightBlue,
          size: 50.0,
        ),
      ),
    );
  }
}
