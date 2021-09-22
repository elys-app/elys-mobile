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
  final String? _contentId;
  final String? _name;
  final String? _eventDate;
  final String? _eventMonth;
  final String? _eventYear;
  final String? _description;
  final Content? _content;
  final Group? _group;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get contentId {
    try {
      return _contentId!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get eventDate {
    try {
      return _eventDate!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get eventMonth {
    try {
      return _eventMonth!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get eventYear {
    try {
      return _eventYear!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String? get description {
    return _description;
  }
  
  Content? get content {
    return _content;
  }
  
  Group? get group {
    return _group;
  }
  
  const Event._internal({required this.id, required contentId, required name, required eventDate, required eventMonth, required eventYear, description, content, group}): _contentId = contentId, _name = name, _eventDate = eventDate, _eventMonth = eventMonth, _eventYear = eventYear, _description = description, _content = content, _group = group;
  
  factory Event({String? id, required String contentId, required String name, required String eventDate, required String eventMonth, required String eventYear, String? description, Content? content, Group? group}) {
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
      _contentId == other._contentId &&
      _name == other._name &&
      _eventDate == other._eventDate &&
      _eventMonth == other._eventMonth &&
      _eventYear == other._eventYear &&
      _description == other._description &&
      _content == other._content &&
      _group == other._group;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Event {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("contentId=" + "$_contentId" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("eventDate=" + "$_eventDate" + ", ");
    buffer.write("eventMonth=" + "$_eventMonth" + ", ");
    buffer.write("eventYear=" + "$_eventYear" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("group=" + (_group != null ? _group!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Event copyWith({String? id, String? contentId, String? name, String? eventDate, String? eventMonth, String? eventYear, String? description, Content? content, Group? group}) {
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
      _contentId = json['contentId'],
      _name = json['name'],
      _eventDate = json['eventDate'],
      _eventMonth = json['eventMonth'],
      _eventYear = json['eventYear'],
      _description = json['description'],
      _content = json['content']?['serializedData'] != null
        ? Content.fromJson(new Map<String, dynamic>.from(json['content']['serializedData']))
        : null,
      _group = json['group']?['serializedData'] != null
        ? Group.fromJson(new Map<String, dynamic>.from(json['group']['serializedData']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'contentId': _contentId, 'name': _name, 'eventDate': _eventDate, 'eventMonth': _eventMonth, 'eventYear': _eventYear, 'description': _description, 'content': _content?.toJson(), 'group': _group?.toJson()
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
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Content).toString()));
  static final QueryField GROUP = QueryField(
    fieldName: "group",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Group).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
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
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.EVENTDATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.EVENTMONTH,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.EVENTYEAR,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Event.CONTENT,
      isRequired: false,
      ofModelName: (Content).toString(),
      associatedKey: Content.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Event.GROUP,
      isRequired: false,
      targetName: "groupId",
      ofModelName: (Group).toString()
    ));
  });
}

class _EventModelType extends ModelType<Event> {
  const _EventModelType();
  
  @override
  Event fromJson(Map<String, dynamic> jsonData) {
    return Event.fromJson(jsonData);
  }
}