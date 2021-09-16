import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

import '../models/groupitem.dart';

class GroupsPage extends StatefulWidget {
  GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  bool _errorOccurred = false;

  GroupItem selectedGroup = new GroupItem(id: '0');
  List<GroupItem> entries =
      List<GroupItem>.filled(0, new GroupItem(id: '0'), growable: true);

  @override
  void initState() {
    super.initState();
    _initGroups();
  }

  void _initGroups() async {
    entries.clear();
    try {
      String graphQLDocument = '''query ListGroups {
        listGroups {
          items {
            id
            name
            owner
          }
        }
      }''';
      var operation = Amplify.API.query(
          request: GraphQLRequest<String>(
        document: graphQLDocument,
      ));
      var response = await operation.response;

      setState(() {
        Map<String, dynamic> data = jsonDecode(response.data)['listGroups'];
        for (var item in data['items']) {
          entries.add(GroupItem.fromJSON(item));
        }
        _errorOccurred = false;
        selectedGroup = entries.elementAt(0);
      });
    } on ApiException {
      setState(() {
        _errorOccurred = true;
      });
    }
  }

  List<DropdownMenuItem<GroupItem>> _getGroupDropdownItems() {
    return (entries
        .map((item) => new DropdownMenuItem<GroupItem>(
            value: item, child: Text(item.name)))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: _errorOccurred
            ? <Widget>[Text('An Error Occurred')]
            : <Widget>[
                DropdownButton<GroupItem>(
                  value: selectedGroup,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 18,
                  elevation: 24,
                  isExpanded: true,
                  underline: Container(
                    height: 1,
                    color: Colors.white,
                  ),
                  onChanged: (GroupItem? newValue) {
                    setState(() {
                      selectedGroup = newValue!;
                    });
                  },
                  items: _getGroupDropdownItems(),
                ),
              ],
      ),
    );
  }
}
