import 'package:flutter/material.dart';

// import 'package:image_picker/image_picker.dart';

class NewSchedulePage extends StatefulWidget {
  NewSchedulePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _NewSchedulePageState createState() => _NewSchedulePageState();
}

class _NewSchedulePageState extends State<NewSchedulePage> {
  String _pictureText = 'Tap the Button to Add a Picture';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
              child: const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
              child: Center(
                child: Row(
                  children: <Widget>[
                    IconButton(
                      color: Colors.lightBlue,
                      icon: new Icon(Icons.camera_alt, size: 36.0),
                      onPressed: () {
                        final snackBar = SnackBar(
                          content: Text('To Do: Take a Picture'),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                    Text(_pictureText, style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 200),
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Add New Content'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
