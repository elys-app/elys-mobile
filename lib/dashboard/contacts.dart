import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<String> entries = List<String>.filled(0, '', growable: true);

  @override
  void initState() {
    super.initState();
    _initContent();
  }

  void _initContent() {
    setState(() {
      entries.add('One');
      entries.add('Two');
      entries.add('Three');
      entries.add('Four');
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
