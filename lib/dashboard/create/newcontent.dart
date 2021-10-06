import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class NewContentPage extends StatefulWidget {
  NewContentPage({Key? key}) : super(key: key);

  @override
  _NewContentPageState createState() => _NewContentPageState();
}

class _NewContentPageState extends State<NewContentPage> {
  bool _imageSelected = false;
  File _image = new File('');

  final formKey = GlobalKey<FormState>();
  final imagePicker = ImagePicker();
  final descriptionController = TextEditingController();
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), primary: Colors.lightBlue);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);
        _imageSelected = true;
        print(image.path);
        print(_imageSelected.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Content',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: 30.0, top: 5.0, right: 30.0, bottom: 5.0),
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
                    labelText: 'Description',
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, top: 5.0, right: 30.0, bottom: 5.0),
                  child: !_imageSelected
                      ? Text('No Image Selected')
                      : Container(
                          child: Image.file(_image), height: 320, width: 320)),
              SizedBox(height: 64),
              const SizedBox(height: 30),
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
                _getImage();
              },
              child: const Icon(Icons.camera_sharp),
              heroTag: null,
              backgroundColor: _imageSelected ? Colors.lightBlue[100] : Colors.lightBlue,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: FloatingActionButton(
              onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, '/main');
                      }
                    },
              child: const Icon(Icons.upload_sharp),
              heroTag: null,
              backgroundColor: _imageSelected ? Colors.lightBlue : Colors.lightBlue[100],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main');
              },
              child: const Icon(Icons.arrow_back_ios_sharp),
              heroTag: 'Back',
              backgroundColor: Colors.lightBlue,
            ),
          ),
        ],
      ),
    );
  }
}
