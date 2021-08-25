import 'package:flutter/material.dart';

class ContentPage extends StatefulWidget {
  ContentPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Content Page',
                style: TextStyle(color: Colors.lightBlue, fontSize: 30)),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
