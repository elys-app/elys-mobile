import 'contactitem.dart';

class ContactGroupItem {
  String contactId;
  ContactItem contactItem;

  ContactGroupItem(
      this.contactId,
      this.contactItem);

  factory ContactGroupItem.fromJSON(Map<String, dynamic> json) {
    return ContactGroupItem(
        json['contactId'],
        ContactItem.fromJSON(json['contact']));
  }
}
