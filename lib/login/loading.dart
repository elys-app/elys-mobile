import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:amplify_flutter/amplify.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late StreamSubscription hubSubscription;
  bool _listeningToHub = true;

  @override
  initState() {
    super.initState();
    _startAmplify();
  }

  @override dispose () {
    hubSubscription.cancel();
    super.dispose();
  }

  Future<void> _startAmplify() async {
    try {
      if (Amplify.isConfigured) {
        await Amplify.DataStore.start();
        Navigator.pushNamed(context, '/main');
      }
    } catch (e) {
      print(e);
    }
  }

  // void listenToHub() {
  //   setState(() {
  //     hubSubscription = Amplify.Hub.listen([HubChannel.DataStore], (msg) {
  //       if (msg.eventName == "ready") {
  //          print(msg);
  //       }
  //     });
  //     _listeningToHub = true;
  //   });
  // }

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
