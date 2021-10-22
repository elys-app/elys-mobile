import 'package:elys_mobile/dashboard/dashboard.dart';
import 'package:elys_mobile/dashboard/panic.dart';
import 'package:elys_mobile/dashboard/pending.dart';
import 'package:elys_mobile/dashboard/undefined.dart';

import 'package:elys_mobile/dashboard/create/newcontent.dart';
import 'package:elys_mobile/dashboard/create/newgroup.dart';
import 'package:elys_mobile/dashboard/create/newcontact.dart';
import 'package:elys_mobile/dashboard/create/newschedule.dart';

import 'package:elys_mobile/login/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
      onGenerateRoute: _generateRoute,
      initialRoute: '/',
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => LoginPage(title: 'Welcome to ELYS'));
      case '/main':
        return MaterialPageRoute(builder: (context) => MainPage());
      case '/newcontent':
        return MaterialPageRoute(builder: (context) => NewContentPage());
      case '/newcontact':
        return MaterialPageRoute(builder: (context) => NewContactPage());
      case '/newgroup':
        return MaterialPageRoute(builder: (context) => NewGroupPage());
      case '/newschedule':
        return MaterialPageRoute(builder: (context) => NewSchedulePage());
      case '/panic':
        return MaterialPageRoute(builder: (context) => PanicPage());
      case '/pending':
        XFile _content = settings.arguments as XFile;
        return MaterialPageRoute(
            builder: (context) => PendingPage(content: _content));

      case '/loading':
        String _destination = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => LoadingPage(destination: _destination));
      default:
        String _name = settings.name!;
        return MaterialPageRoute(
            builder: (context) => UndefinedView(name: _name));
    }
  }
}
