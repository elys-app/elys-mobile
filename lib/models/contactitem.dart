class ContactItem {
  String id;
  String name;
  String email;

  ContactItem({this.id = '0', this.name = '', this.email = ''});

  factory ContactItem.fromJSON(Map<String, dynamic> json) {
    return ContactItem(
        id: json['id'],
        name: json['name'],
        email: json['email']);
  }
}
