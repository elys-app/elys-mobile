import 'package:flutter/material.dart';
import 'detail.dart';
import 'groups.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: <Widget>[
        Column(children: <Widget>[
          Center(
              child: Text('Your Contacts',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 14))),
          DetailsPage()
        ]),
        Column(children: <Widget>[
          Center(
            child: Text(
              'Your Groups',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            ),
          ),
          GroupsPage()
        ])
      ],
    );
  }
}
