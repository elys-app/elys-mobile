import 'package:meta/meta.dart';
import 'dart:convert';

class Contact {
  String id;
  String name;
  String email;

  Contact({this.id = '0', this.name = '', this.email = ''});

  factory Contact.fromJSON(Map<String, dynamic> json) {
    return Contact(
        id: json['id'],
        name: json['name'],
        email: json['email']);
  }
}
