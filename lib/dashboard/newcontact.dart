import 'package:flutter/material.dart';

class NewContactPage extends StatefulWidget {
  NewContactPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _NewContactPageState createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
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
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
              child: const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  labelText: 'Email Address',
                ),
              ),
            ),
            SizedBox(height: 200),
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Add New Contact'),
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
