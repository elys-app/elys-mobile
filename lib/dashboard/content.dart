import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:amplify_flutter/amplify.dart';

import 'package:elys_mobile/models/Content.dart';

class ContentPage extends StatefulWidget {
  ContentPage({Key? key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  bool _errorOccurred = false;

  List<Content> entries = List<Content>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _getContent();
    _observeContent();
  }

  @override
  void setState(fn) {
    if (this.mounted) {
      super.setState(fn);
    }
  }

  void _getContent() async {
    try {
      final result = await Amplify.DataStore.query(Content.classType,
          sortBy: [Content.DESCRIPTION.ascending()]);
      setState(() {
        entries = result;
        _errorOccurred = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _errorOccurred = true;
      });
    }
  }

  void _observeContent() async {
    final contentStream = await Amplify.DataStore.observe(Content.classType);
    contentStream.listen((_) => _getContent());
  }

  List<Column> _getContentList() {
    return (entries
        .map(
          (item) => Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  item.description,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(item.name),
                isThreeLine: false,
                onLongPress: () {
                  print('Remove item');
                },
              ),
              Divider(thickness: 1)
            ],
          ),
        )
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
            children: _errorOccurred
                ? <Widget>[Text('An Error Occurred')]
                : _getContentList()));
  }
}
