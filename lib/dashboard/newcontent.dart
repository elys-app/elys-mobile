import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewContentPage extends StatefulWidget {
  NewContentPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _NewContentPageState createState() => _NewContentPageState();
}

class _NewContentPageState extends State<NewContentPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    final ButtonStyle contentStyle = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20), primary: Colors.lightBlue);

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
              child: OutlinedButton(
                style: style,
                child: Text('Take a Photo'),
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
            ),
            ElevatedButton(
              style: style,
              onPressed: null,
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
