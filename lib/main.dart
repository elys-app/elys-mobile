import 'package:elys_mobile/dashboard/dashboard.dart';
import 'package:elys_mobile/dashboard/panic.dart';

import 'package:elys_mobile/dashboard/create/newcontent.dart';
import 'package:elys_mobile/dashboard/create/newgroup.dart';
import 'package:elys_mobile/dashboard/create/newcontact.dart';
import 'package:elys_mobile/dashboard/create/newschedule.dart';

import 'package:elys_mobile/login/loading.dart';
import 'package:flutter/material.dart';
import 'login/login.dart';

void main() {
  runApp(ElysApp());
}

class ElysApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
      ),
      routes: {
        '/': (context) => LoginPage(title: 'Welcome to ELYS'),
        '/loading': (context) => LoadingPage(),
        '/panic': (context) => PanicPage(),
        '/main': (context) => MainPage(),
        '/newcontent': (context) => NewContentPage(),
        '/newcontact': (context) => NewContactPage(),
        '/newgroup': (context) => NewGroupPage(),
        '/newschedule': (context) => NewSchedulePage()
      },
      initialRoute: '/',
    );
  }
}
