import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

import '../../models/Content.dart';

class ContentPage extends StatefulWidget {
  ContentPage({Key? key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  List<Content> entries = List<Content>.empty(growable: true);

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

  Future<void> _getContent() async {
    try {
      final result = await Amplify.DataStore.query(Content.classType,
          sortBy: [Content.DESCRIPTION.ascending()]);
      setState(() {
        entries = result;
      });
    } catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {});
    }
  }

  void _observeContent() async {
    final contentStream = Amplify.DataStore.observe(Content.classType);
    contentStream.listen((_) => _getContent());
  }

  Future<List<ListTile>> _getContentList() async {
    _observeContent();
    final result = await Amplify.DataStore.query(Content.classType,
        sortBy: [Content.DESCRIPTION.ascending()]);
    return (result
        .map(
          (item) => ListTile(
            title: Text(
              item.description,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(item.name),
            isThreeLine: false,
            onLongPress: () {
              Navigator.pushNamed(context, '/editcontent', arguments: item);
            },
          ),
        )
        .toList());
  }

  Widget _getContentItems() {
    return FutureBuilder(
      future: _getContentList(),
      builder: (BuildContext context, AsyncSnapshot<List<ListTile>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length > 0) {
            return new ListView.separated(
                separatorBuilder: (context, item) => Divider(thickness: 1),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, item) {
                  return snapshot.data![item];
                });
          }
          else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: new
              Text('No Media Items found',
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
            child: Text('Upload any photo or video for future messages',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 18),
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
          Expanded(
              child: _getContentItems()
          )
        ],
      ),
    );
  }
}
