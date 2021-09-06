import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
      entries.add('Alfa');
      entries.add('Bravo');
      entries.add('Charlie');
      entries.add('Delta');
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
