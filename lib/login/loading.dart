import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:amplify_flutter/amplify.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key, required this.destination}) : super(key: key);

  final String destination;

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late StreamSubscription hubSubscription;

  @override
  initState() {
    super.initState();
    _startAmplify();
  }

  @override
  dispose() {
    super.dispose();
    hubSubscription.cancel();
  }

  Future<void> _startAmplify() async {
    try {
      if (Amplify.isConfigured) {
        await Amplify.DataStore.start();
        hubSubscription = Amplify.Hub.listen([HubChannel.DataStore], (event) {
          print('Event: ${event.eventName}');
          if (event.eventName == 'ready') {
            if (widget.destination == 'main') {
              Navigator.pushNamed(context, '/main');
            }
            else {
              Navigator.pushNamed(context, '/panic');
            }
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _exit() async {
    await Amplify.DataStore.clear();
    await Amplify.Auth.signOut();
    Navigator.pushNamed(context, '/');
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
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SpinKitThreeBounce(
              color: Colors.lightBlue,
              size: 50.0,
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    _exit();
                  },
                  child: Text(
                    'Stuck?',
                    style: TextStyle(fontSize: 20),
                  ),
                ))
          ]),
    );
  }
}
