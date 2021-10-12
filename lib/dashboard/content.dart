import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

import '../models/Content.dart';

class ContentPage extends StatefulWidget {
  ContentPage({Key? key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  List<Content> entries = List<Content>.empty(growable: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (this.mounted) {
      super.setState(fn);
    }
  }

  Future<void> _getContent() async {
    try {
      final result = await Amplify.DataStore.query(Content.classType,
          sortBy: [Content.DESCRIPTION.ascending()]);
      setState(() {
        entries = result;
      });
    } catch (e) {
      print(e);
      setState(() {});
    }
  }

  void _observeContent() async {
    final contentStream = await Amplify.DataStore.observe(Content.classType);
    contentStream.listen((_) => _getContent());
  }

  Future<List<ListTile>> _getContentList() async {
    _observeContent();
    final result = await Amplify.DataStore.query(Content.classType,
        sortBy: [Content.DESCRIPTION.ascending()]);
    return (result
        .map(
          (item) => ListTile(
            title: Text(
              item.description,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(item.name),
            isThreeLine: false,
            onLongPress: () {
              _removeContentItem(item);
            },
          ),
        )
        .toList());
  }

  Widget _getContentItems() {
    return FutureBuilder(
      future: _getContentList(),
      builder: (BuildContext context, AsyncSnapshot<List<ListTile>> snapshot) {
        if (snapshot.hasData) {
          return new ListView.separated(
              separatorBuilder: (context, item) => Divider(thickness: 1),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, item) {
                return snapshot.data![item];
              });
        } else {
          return Container(
            child: SpinKitThreeBounce(
              color: Colors.lightBlue,
              size: 50.0,
            ),
          );
        }
      },
    );
  }

  void _removeContentItem(Content item) async {
    try {
      await Amplify.Storage.remove(key: item.key);
    } on StorageException catch (e) {
      print('Error deleting file: $e');
    }
    await Amplify.DataStore.delete(item);
  }

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10), child: _getContentItems());
  }
}
