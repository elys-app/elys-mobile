import 'package:flutter/material.dart';

class ContentPage extends StatefulWidget {
  ContentPage({Key? key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  List<String> entries = List<String>.filled(0, '', growable: true);

  @override
  void initState() {
    super.initState();
    _initContent();
  }

  void _initContent() {
    setState(() {
      entries.add('A');
      entries.add('B');
      entries.add('C');
      entries.add('D');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: Center(child: Text('Entry ${entries[index]}')),
                  );
                }),
        ),
    );
  }
}
