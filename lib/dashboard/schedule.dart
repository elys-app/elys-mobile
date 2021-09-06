import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<String> entries = List<String>.filled(0, '', growable: true);

  @override
  void initState() {
    super.initState();
    _initContent();
  }

  void _initContent() {
    setState(() {
      entries.add('Whiskey');
      entries.add('XRay');
      entries.add('Yankee');
      entries.add('Zulu');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
          children: entries
              .map(
                (item) => new Slidable(
                key: Key(item),
                actionPane: SlidableDrawerActionPane(),
                child: ListTile(
                  title: Text(
                    item.toString(),
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Additional Text'),
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
              .toList()),
    );
  }
}
