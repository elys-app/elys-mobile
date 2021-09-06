import 'package:meta/meta.dart';

class ContentItem {
  String id;
  String owner;
  String description;
  String name;
  String type;

  ContentItem({this.id = '0',
    this.owner = '',
    this.description = '',
    this.name = '',
    this.type = ''}) {
    assert(id != null);
  }
}
