import 'dart:core';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';

import '../../models/Content.dart';

class EditContentPage extends StatefulWidget {
  EditContentPage({Key? key, required this.contentItem}) : super(key: key);

  final Content contentItem;

  @override
  _EditContentPageState createState() => _EditContentPageState();
}

class _EditContentPageState extends State<EditContentPage> {
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    descriptionController.text = widget.contentItem.description;
    nameController.text = widget.contentItem.name;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> onEditContentPressed() async {
    try {
      Content updatedContent = widget.contentItem.copyWith(
          id: widget.contentItem.id,
          description: descriptionController.text);
      await Amplify.DataStore.save(updatedContent);
      print('Updated: ${updatedContent.toString()}');

      Navigator.pushNamed(context, '/main', arguments: 'content');
    } catch (e) {
      print(e.toString());
    }
  }

  void onDeleteContentPressed() async {
    try {
      await Amplify.Storage.remove(key: widget.contentItem.key);
    } on StorageException catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text('${e.message}'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    await Amplify.DataStore.delete(widget.contentItem);
    Navigator.pushNamed(context, '/main', arguments: 'content');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit My Media',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 100),
              Padding(
                padding: EdgeInsets.only(
                    left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter a Description';
                    }
                    return null;
                  },
                  controller: descriptionController,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.description_sharp),
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter a Description';
                    }
                    return null;
                  },
                  controller: nameController,
                  enabled: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.description_sharp),
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
            ],
          ),
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
                onDeleteContentPressed();
              },
              child: const Icon(Icons.delete_sharp),
              heroTag: null,
              backgroundColor: Colors.pink,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main', arguments: 'content');
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
