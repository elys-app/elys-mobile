import 'package:elys_mobile/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:elys_mobile/hotbutton/panic.dart';
import 'package:elys_mobile/hotbutton/pending.dart';
import 'package:elys_mobile/hotbutton/camera.dart';

import 'package:elys_mobile/dashboard/dashboard.dart';
import 'package:elys_mobile/dashboard/startup.dart';
import 'package:elys_mobile/dashboard/undefined.dart';

import 'package:elys_mobile/dashboard/create/newcontent.dart';
import 'package:elys_mobile/dashboard/create/pendingcontent.dart';
import 'package:elys_mobile/dashboard/create/newcontact.dart';
import 'package:elys_mobile/dashboard/create/newschedule.dart';

import 'package:elys_mobile/dashboard/edit/editcontent.dart';
import 'package:elys_mobile/dashboard/edit/editcontact.dart';
import 'package:elys_mobile/dashboard/edit/editschedule.dart';

import 'package:elys_mobile/dashboard/related/contentrelated.dart';
import 'package:elys_mobile/dashboard/related/contactrelated.dart';

import 'package:elys_mobile/login/login.dart';
import 'package:elys_mobile/login/loading.dart';
import 'package:elys_mobile/login/register.dart';

import 'package:elys_mobile/settings/econtact.dart';
import 'package:elys_mobile/models/PendingPage.dart';
import 'package:elys_mobile/models/PendingContentPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://993c8574b1a24a3689c4ea54940fd255@o1277891.ingest.sentry.io/6475702';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(ElysApp()),
  );
}

class ElysApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      onGenerateRoute: _generateRoute,
      initialRoute: '/',
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => LoginPage(title: 'Welcome to Elys'));
      case '/register':
        return MaterialPageRoute(builder: (context) => RegisterPage());
      case '/main':
        if (settings.arguments != null) {
          String _page = settings.arguments as String;
          return MaterialPageRoute(builder: (context) => MainPage(page: _page));
        } else {
          return MaterialPageRoute(builder: (context) => MainPage(page: ''));
        }
      case '/newcontent':
        return MaterialPageRoute(builder: (context) => NewContentPage());
      case '/pendingcontent':
        PendingContentPageArguments info =
            settings.arguments as PendingContentPageArguments;
        return MaterialPageRoute(
          builder: (context) =>
              PendingContentPage(item: info.item, content: info.content),
        );
      case '/relatedcontent':
        Content _content = settings.arguments as Content;
        return MaterialPageRoute(
            builder: (context) => ContentRelatedPage(item: _content));
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
      case '/relatedcontact':
        Contact _contact = settings.arguments as Contact;
        return MaterialPageRoute(
            builder: (context) => ContactRelatedPage(item: _contact));
      case '/startup':
        String _variation = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => StartupPage(variation: _variation));
      case '/newschedule':
        return MaterialPageRoute(builder: (context) => NewSchedulePage());
      case '/editschedule':
        Event _event = settings.arguments as Event;
        return MaterialPageRoute(
            builder: (context) => EditSchedulePage(eventItem: _event));
      case '/panic':
        return MaterialPageRoute(builder: (context) => PanicPage());
      case '/pending':
        PendingPageArguments info = settings.arguments as PendingPageArguments;
        return MaterialPageRoute(
          builder: (context) =>
              PendingPage(event: info.event, content: info.content),
        );
      case '/camera':
        SpecialEvent _event = settings.arguments as SpecialEvent;
        return MaterialPageRoute(
            builder: (context) => CameraPage(event: _event));
      case '/loading':
        String _destination = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => LoadingPage(destination: _destination));
      case '/settings':
        return MaterialPageRoute(builder: (context) => SettingsPage());
      default:
        String _name = settings.name!;
        return MaterialPageRoute(
            builder: (context) => UndefinedView(name: _name));
    }
  }
}
