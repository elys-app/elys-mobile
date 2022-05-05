import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../models/Contact.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<Contact> entries = List<Contact>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _getContacts();
    _observeContacts();
  }

  @override
  void setState(fn) {
    if (this.mounted) {
      super.setState(fn);
    }
  }

  void _getContacts() async {
    try {
      final result = await Amplify.DataStore.query(Contact.classType,
          sortBy: [Contact.NAME.ascending()]);
      setState(() {
        entries = result;
      });
    } catch (e) {
      setState(() {});
    }
  }

  void _observeContacts() async {
    final contactStream = Amplify.DataStore.observe(Contact.classType);
    contactStream.listen((_) => _getContacts());
  }

  Future<List<ListTile>> _getContactList() async {
    final result = await Amplify.DataStore.query(Contact.classType,
        sortBy: [Contact.NAME.ascending()]);

    return (result
        .map((item) => ListTile(
              title: Text(item.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text(item.email),
              isThreeLine: false,
              onLongPress: () {
                Navigator.pushNamed(context, '/editcontact', arguments: item);
              },
            ))
        .toList());
  }

  Widget _getContactItems() {
    return FutureBuilder(
      future: _getContactList(),
      builder: (BuildContext context, AsyncSnapshot<List<ListTile>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length > 0) {
            return new ListView.separated(
                separatorBuilder: (context, item) => Divider(thickness: 1),
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, item) {
                  return snapshot.data![item];
                });
          }
          else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: new
              Text('No Connections found',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18)),
            );
          }
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Add, change, or delete any connections you want to send future messages',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 18)),
            ),
          ),
          Divider(
            height: 20,
            thickness: 2,
            indent: 0,
            endIndent: 0,
            color: Colors.black,
          ),
          Expanded(
            child: _getContactItems()
          )
        ],
      ),
    );
  }
}
