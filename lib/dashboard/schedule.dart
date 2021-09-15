import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

import '../models/scheduleitem.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _errorOccurred = false;

  List<ScheduleItem> entries =
  List<ScheduleItem>.filled(0, new ScheduleItem(id: '0'), growable: true);

  @override
  void initState() {
    super.initState();
    _initEvents();
  }

  void _initEvents() async {
    entries.clear();
    try {
      String graphQLDocument = '''query ListEvents {
        listEvents {
          items {
            contentId
            createdAt
            description
            eventDate
            eventMonth
            eventYear
            groupId
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
        Map<String, dynamic> data = jsonDecode(response.data)['listEvents'];
        for (var item in data['items']) {
          entries.add(ScheduleItem.fromJSON(item));
        }
        _errorOccurred = false;
      });
    } on ApiException {
      setState(() {
        _errorOccurred = true;
      });
    }

  }

  List<Slidable> _getEventList() {
    return (entries
        .map(
          (item) => new Slidable(
          actionPane: SlidableDrawerActionPane(),
          child: ListTile(
            title: Text(
              item.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Group to Share With: ${item.groupId}\nDate: ${item.eventDate} ${item.eventMonth}'),
            isThreeLine: true,
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
    ).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(children: _errorOccurred ? <Widget>[
          Text('An Error Occurred')] : _getEventList()));
  }
}
