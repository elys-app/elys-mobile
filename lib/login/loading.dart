import 'dart:async';
import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key, required this.destination}) : super(key: key);

  final String destination;

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late StreamSubscription hubSubscription;
  double completed = 0.02;

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
          setState(() {
            completed += (0.98 / 12.0);
          });
          if (event.eventName == 'ready') {
            if (widget.destination == 'main') {
              Navigator.pushNamed(context, '/main', arguments: 'contact');
            } else {
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
    Amplify.Auth.signOut();
    Navigator.pushNamed(context, '/main');
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 40.0),
                child: Text(
                    'We are loading Content from Elys\nThis might take a couple seconds...',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue))),
            SizedBox(
              child: CircularProgressIndicator(value: completed),
              width: 100,
              height: 100,
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    _exit();
                  },
                  child: Text(
                    'Work Offline',
                    style: TextStyle(fontSize: 20),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
