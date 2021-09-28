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

  List<Content> entries = List<Content>.filled(
      0,
      new Content(
          id: '0',
          name: '',
          description: '',
          bucket: '',
          key: '',
          region: '',
          type: '',
          dateSubmitted: ''),
      growable: true);

  @override
  void initState() {
    super.initState();
    _initContent();
  }

  void _initContent() async {
    entries.clear();
    try {
      final result = await Amplify.DataStore.query(Content.classType);
      result.sort((a, b) => a.name.compareTo(b.name));
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

  List<Slidable> _getContentList() {
    return (entries
        .map(
          (item) => new Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: ListTile(
                title: Text(
                  item.description,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(item.name),
              ),
              secondaryActions: <Widget>[
                IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.cancel,
                    onTap: () => {
                          setState(
                            () {
                              entries.remove(item);
                            },
                          )
                        }),
              ]),
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
