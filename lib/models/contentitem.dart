class ContentItem {
  String id;
  String owner;
  String description;
  String name;
  String type;

  ContentItem(
      {this.id = '0',
      this.owner = '',
      this.description = '',
      this.name = '',
      this.type = ''});

  factory ContentItem.fromJSON(Map<String, dynamic> json) {
    return ContentItem(
        id: json['id'],
        owner: json['owner'],
        description: json['description'],
        name: json['name'],
        type: json['type']);
  }
}
