import 'package:flutter/material.dart';
import 'detail.dart';
import 'groups.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: currentPageIndex);
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      onPageChanged: (int value) {
        setState(() {
          currentPageIndex = value;
          print('Index: ' + currentPageIndex.toString());
        });
      },
      children: <Widget>[
        Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: 10.0, top: 10.0, right: 10.0, bottom: 5.0),
            child: Center(
              child: Text('Your Contacts',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
          ),
          Divider(thickness: 5),
          DetailsPage()
        ]),
        Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: 10.0, top: 10.0, right: 10.0, bottom: 5.0),
            child: Center(
              child: Text('Your Groups',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
          ),
          Divider(thickness: 5),
          // GroupsPage()
        ])
      ],
    );
  }
}
