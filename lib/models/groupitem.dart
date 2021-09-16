class GroupItem {
  String id;
  String name;

  GroupItem({this.id = '0', this.name = ''});

  factory GroupItem.fromJSON(Map<String, dynamic> json) {
    return GroupItem(
        id: json['id'],
        name: json['name']
    );
  }
}
