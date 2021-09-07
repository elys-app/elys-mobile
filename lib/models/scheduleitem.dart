class ScheduleItem {
  String id;
  String name;
  String description;
  String groupId;
  String contentId;
  String eventDate;
  String eventMonth;
  String eventYear;

  ScheduleItem(
      {this.id = '0',
      this.name = '',
      this.description = '',
      this.contentId = '',
      this.groupId = '',
      this.eventDate = '',
      this.eventMonth = '',
      this.eventYear = ''});

  factory ScheduleItem.fromJSON(Map<String, dynamic> json) {
    return ScheduleItem(
        id: json['id'],
        name: json['name'],
        groupId: json['groupId'],
        contentId: json['contentId'],
        eventDate: json['eventDate'],
        eventMonth: json['eventMonth'],
        eventYear: json['eventYear']);
  }
}
