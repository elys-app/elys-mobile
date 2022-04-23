import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/Contact.dart';
import '../models/Content.dart';

import 'package:elys_mobile/dashboard/dashboard.dart';
import 'package:elys_mobile/dashboard/panic.dart';
import 'package:elys_mobile/dashboard/pending.dart';
import 'package:elys_mobile/dashboard/undefined.dart';

import 'package:elys_mobile/dashboard/create/newcontent.dart';
import 'package:elys_mobile/dashboard/edit/editcontent.dart';
import 'package:elys_mobile/dashboard/create/newcontact.dart';
import 'package:elys_mobile/dashboard/edit/editcontact.dart';
import 'package:elys_mobile/dashboard/create/newschedule.dart';

import 'package:elys_mobile/login/login.dart';
import 'package:elys_mobile/login/loading.dart';

import 'models/Content.dart';

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
        if (settings.arguments != null) {
          String _page = settings.arguments as String;
          return MaterialPageRoute(builder: (context) => MainPage(page: _page));
        } else {
          return MaterialPageRoute(builder: (context) => MainPage(page: ''));
        }
      case '/newcontent':
        return MaterialPageRoute(builder: (context) => NewContentPage());
      case '/editcontent':
        Content _content = settings.arguments as Content;
        return MaterialPageRoute(
            builder: (context) => EditContentPage(contentItem: _content));
      case '/newcontact':
        return MaterialPageRoute(builder: (context) => NewContactPage());
      case '/editcontact':
        Contact _contact = settings.arguments as Contact;
        return MaterialPageRoute(
            builder: (context) => EditContactPage(contactItem: _contact));
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
