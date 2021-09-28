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

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Event type in your schema. */
@immutable
class Event extends Model {
  static const classType = const _EventModelType();
  final String id;
  final String? _groupId;
  final String? _contentId;
  final String? _name;
  final String? _eventDate;
  final String? _eventMonth;
  final String? _eventYear;
  final String? _description;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get groupId {
    try {
      return _groupId!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
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
  
  const Event._internal({required this.id, required groupId, required contentId, required name, required eventDate, required eventMonth, required eventYear, description}): _groupId = groupId, _contentId = contentId, _name = name, _eventDate = eventDate, _eventMonth = eventMonth, _eventYear = eventYear, _description = description;
  
  factory Event({String? id, required String groupId, required String contentId, required String name, required String eventDate, required String eventMonth, required String eventYear, String? description}) {
    return Event._internal(
      id: id == null ? UUID.getUUID() : id,
      groupId: groupId,
      contentId: contentId,
      name: name,
      eventDate: eventDate,
      eventMonth: eventMonth,
      eventYear: eventYear,
      description: description);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Event &&
      id == other.id &&
      _groupId == other._groupId &&
      _contentId == other._contentId &&
      _name == other._name &&
      _eventDate == other._eventDate &&
      _eventMonth == other._eventMonth &&
      _eventYear == other._eventYear &&
      _description == other._description;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Event {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("groupId=" + "$_groupId" + ", ");
    buffer.write("contentId=" + "$_contentId" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("eventDate=" + "$_eventDate" + ", ");
    buffer.write("eventMonth=" + "$_eventMonth" + ", ");
    buffer.write("eventYear=" + "$_eventYear" + ", ");
    buffer.write("description=" + "$_description");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Event copyWith({String? id, String? groupId, String? contentId, String? name, String? eventDate, String? eventMonth, String? eventYear, String? description}) {
    return Event(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      contentId: contentId ?? this.contentId,
      name: name ?? this.name,
      eventDate: eventDate ?? this.eventDate,
      eventMonth: eventMonth ?? this.eventMonth,
      eventYear: eventYear ?? this.eventYear,
      description: description ?? this.description);
  }
  
  Event.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _groupId = json['groupId'],
      _contentId = json['contentId'],
      _name = json['name'],
      _eventDate = json['eventDate'],
      _eventMonth = json['eventMonth'],
      _eventYear = json['eventYear'],
      _description = json['description'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'groupId': _groupId, 'contentId': _contentId, 'name': _name, 'eventDate': _eventDate, 'eventMonth': _eventMonth, 'eventYear': _eventYear, 'description': _description
  };

  static final QueryField ID = QueryField(fieldName: "event.id");
  static final QueryField GROUPID = QueryField(fieldName: "groupId");
  static final QueryField CONTENTID = QueryField(fieldName: "contentId");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField EVENTDATE = QueryField(fieldName: "eventDate");
  static final QueryField EVENTMONTH = QueryField(fieldName: "eventMonth");
  static final QueryField EVENTYEAR = QueryField(fieldName: "eventYear");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
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
      key: Event.GROUPID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
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
  });
}

class _EventModelType extends ModelType<Event> {
  const _EventModelType();
  
  @override
  Event fromJson(Map<String, dynamic> jsonData) {
    return Event.fromJson(jsonData);
  }
}