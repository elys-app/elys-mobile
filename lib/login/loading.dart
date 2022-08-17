import 'dart:async';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:sentry/sentry.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:elys_mobile/models/Account.dart';

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
        var user = await Amplify.Auth.getCurrentUser();
        await Amplify.DataStore.clear();
        await Amplify.DataStore.stop();
        await Amplify.DataStore.start();
        hubSubscription =
            Amplify.Hub.listen([HubChannel.DataStore], (event) async {
          print('Event: ${event.eventName}');
          setState(() {
            completed += (0.98 / 12.0);
          });
          if (event.eventName == 'ready') {
            List<Account> result = await Amplify.DataStore.query(
                Account.classType,
                where: Account.USERNAME.eq(user.username));
            if (result.length > 0) {
              if (widget.destination == 'main') {
                Navigator.pushReplacementNamed(context, '/main', arguments: 'contact');
              } else {
                Navigator.pushReplacementNamed(context, '/panic');
              }
            } else {
              Navigator.pushReplacementNamed(context, '/panic');
            }
          }
        });
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _exit() async {
    await Amplify.DataStore.clear();
    await Amplify.DataStore.stop();
    Amplify.Auth.signOut().then((_) {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Loading Elys',
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
                padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 40.0),
                child: Text(
                    'We are loading Content from Elys\nThis might take a couple seconds...',
                    style: TextStyle(
                        fontSize: 18,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
