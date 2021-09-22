/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Event type in your schema. */
@immutable
class Event extends Model {
  static const classType = const _EventModelType();
  final String id;
  final String contentId;
  final String name;
  final String eventDate;
  final String eventMonth;
  final String eventYear;
  final String description;
  final Content content;
  final Group group;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Event._internal(
      {@required this.id,
      @required this.contentId,
      @required this.name,
      @required this.eventDate,
      @required this.eventMonth,
      @required this.eventYear,
      this.description,
      this.content,
      this.group});

  factory Event(
      {String id,
      @required String contentId,
      @required String name,
      @required String eventDate,
      @required String eventMonth,
      @required String eventYear,
      String description,
      Content content,
      Group group}) {
    return Event._internal(
        id: id == null ? UUID.getUUID() : id,
        contentId: contentId,
        name: name,
        eventDate: eventDate,
        eventMonth: eventMonth,
        eventYear: eventYear,
        description: description,
        content: content,
        group: group);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Event &&
        id == other.id &&
        contentId == other.contentId &&
        name == other.name &&
        eventDate == other.eventDate &&
        eventMonth == other.eventMonth &&
        eventYear == other.eventYear &&
        description == other.description &&
        content == other.content &&
        group == other.group;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Event {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("contentId=" + "$contentId" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("eventDate=" + "$eventDate" + ", ");
    buffer.write("eventMonth=" + "$eventMonth" + ", ");
    buffer.write("eventYear=" + "$eventYear" + ", ");
    buffer.write("description=" + "$description" + ", ");
    buffer.write("group=" + (group != null ? group.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Event copyWith(
      {String id,
      String contentId,
      String name,
      String eventDate,
      String eventMonth,
      String eventYear,
      String description,
      Content content,
      Group group}) {
    return Event(
        id: id ?? this.id,
        contentId: contentId ?? this.contentId,
        name: name ?? this.name,
        eventDate: eventDate ?? this.eventDate,
        eventMonth: eventMonth ?? this.eventMonth,
        eventYear: eventYear ?? this.eventYear,
        description: description ?? this.description,
        content: content ?? this.content,
        group: group ?? this.group);
  }

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        contentId = json['contentId'],
        name = json['name'],
        eventDate = json['eventDate'],
        eventMonth = json['eventMonth'],
        eventYear = json['eventYear'],
        description = json['description'],
        content = json['content'] != null
            ? Content.fromJson(new Map<String, dynamic>.from(json['content']))
            : null,
        group = json['group'] != null
            ? Group.fromJson(new Map<String, dynamic>.from(json['group']))
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'contentId': contentId,
        'name': name,
        'eventDate': eventDate,
        'eventMonth': eventMonth,
        'eventYear': eventYear,
        'description': description,
        'content': content?.toJson(),
        'group': group?.toJson()
      };

  static final QueryField ID = QueryField(fieldName: "event.id");
  static final QueryField CONTENTID = QueryField(fieldName: "contentId");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField EVENTDATE = QueryField(fieldName: "eventDate");
  static final QueryField EVENTMONTH = QueryField(fieldName: "eventMonth");
  static final QueryField EVENTYEAR = QueryField(fieldName: "eventYear");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField CONTENT = QueryField(
      fieldName: "content",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Content).toString()));
  static final QueryField GROUP = QueryField(
      fieldName: "group",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Group).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Event";
    modelSchemaDefinition.pluralName = "Events";

    modelSchemaDefinition.authRules = [
      AuthRule(
          authStrategy: AuthStrategy.OWNER,
          ownerField: "owner",
          identityClaim: "cognito:username",
          operations: [
            ModelOperation.CREATE,
            ModelOperation.UPDATE,
            ModelOperation.DELETE,
            ModelOperation.READ
          ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.CONTENTID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.EVENTDATE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.EVENTMONTH,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.EVENTYEAR,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.DESCRIPTION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: Event.CONTENT,
        isRequired: false,
        ofModelName: (Content).toString(),
        associatedKey: Content.ID));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Event.GROUP,
        isRequired: false,
        targetName: "groupId",
        ofModelName: (Group).toString()));
  });
}

class _EventModelType extends ModelType<Event> {
  const _EventModelType();

  @override
  Event fromJson(Map<String, dynamic> jsonData) {
    return Event.fromJson(jsonData);
  }
}
