import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({Key? key, required this.variation}) : super(key: key);

  final String variation;

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {

  bool _showAddContacts = true;
  bool _showAddContent = true;

  @override
  void initState() {
    super.initState();

    if (widget.variation == 'both') {
      _showAddContacts = true;
      _showAddContent = true;
    }
    if (widget.variation == 'contacts') {
      _showAddContacts = true;
      _showAddContent = false;
    }
    if (widget.variation == 'content') {
      _showAddContacts = false;
      _showAddContent = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Elys Mobile',
            style: GoogleFonts.bellefair(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500)),
          ),
          automaticallyImplyLeading: false),
      body: Form(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Looks like you\'re new here!\n\nTo Schedule an Event, you need a Connection and a Media Item\nPress the button below to get started',
                    style:
                        GoogleFonts.poppins(textStyle: TextStyle(fontSize: 18)),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: !_showAddContacts ? null : () {
                      Navigator.pushNamed(context, '/newcontact');
                    },
                    child: Text(
                      'Add A Connection',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: !_showAddContent ? null : () {
                      Navigator.pushNamed(context, '/newcontent');
                    },
                    child: Text(
                      'Add A Media Item',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
