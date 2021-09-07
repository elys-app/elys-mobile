import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

import '../models/contentitem.dart';

class ContentPage extends StatefulWidget {
  ContentPage({Key? key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  bool _errorOccurred = false;

  List<ContentItem> entries =
      List<ContentItem>.filled(0, new ContentItem(id: '0'), growable: true);

  @override
  void initState() {
    super.initState();
    _initContent();
  }

  void _initContent() async {
    entries.clear();
    try {
      String graphQLDocument = '''query ListContents {
        listContents {
          items {
            id
            name
            owner
            type
            updatedAt
            description
            dateSubmitted
            createdAt
          }
        }
      }''';
      var operation = Amplify.API.query(
          request: GraphQLRequest<String>(
        document: graphQLDocument,
      ));
      var response = await operation.response;

      setState(() {
        Map<String, dynamic> data = jsonDecode(response.data)['listContents'];
        for (var item in data['items']) {
          entries.add(ContentItem.fromJSON(item));
        }
        _errorOccurred = false;
      });
    } on ApiException {
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
        child: Column(children: _errorOccurred ? <Widget>[
          Text('An Error Occurred')
        ] : _getContentList()));
  }
}
