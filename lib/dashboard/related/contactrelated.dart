import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:elys_mobile/models/Contact.dart';
import 'package:elys_mobile/models/Event.dart';

class ContactRelatedPage extends StatefulWidget {
  ContactRelatedPage({Key? key, required Contact this.item}) : super(key: key);

  final Contact item;

  @override
  _ContactRelatedPageState createState() => _ContactRelatedPageState();
}

class _ContactRelatedPageState extends State<ContactRelatedPage> {
  List<Contact> entries = List<Contact>.empty(growable: true);

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

  Future<List<ListTile>> _getEventList() async {
    final result = await Amplify.DataStore.query(Event.classType,
        where: Event.CONTACTID.eq(widget.item.id));

    return (result
        .map(
          (item) => new ListTile(
              title: Text(
                item.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Send Email to: ${item.contactEmail} \nOn: ${item.eventMonth} ${item.eventDate} '),
              isThreeLine: true),
        )
        .toList());
  }

  Widget _getEventItems() {
    return FutureBuilder(
      future: _getEventList(),
      builder: (BuildContext context, AsyncSnapshot<List<ListTile>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length > 0) {
            return new ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, item) => Divider(thickness: 1),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, item) {
                  return snapshot.data![item];
                });
          } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: new Text('\nNo Schedule Items found',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14)),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Elys Mobile',
          style: GoogleFonts.bellefair(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Events relate to the \'${widget.item.name}\' connection',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Divider(
              height: 20,
              thickness: 2,
              indent: 0,
              endIndent: 0,
              color: Colors.black,
            ),
            Expanded(child: _getEventItems())
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main', arguments: 'contact');
              },
              child: const Icon(Icons.arrow_back_ios_sharp),
              backgroundColor: Colors.lightBlue,
            ),
          ),
        ],
      ),
    );
  }
}
