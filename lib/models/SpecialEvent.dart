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

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the SpecialEvent type in your schema. */
@immutable
class SpecialEvent extends Model {
  static const classType = const _SpecialEventModelType();
  final String id;
  final String? _eventId;
  final TemporalDateTime? _timeSubmitted;
  final Event? _event;
  final bool? _warned;
  final bool? _sent;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get eventId {
    try {
      return _eventId!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  TemporalDateTime get timeSubmitted {
    try {
      return _timeSubmitted!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  Event? get event {
    return _event;
  }
  
  bool? get warned {
    return _warned;
  }
  
  bool? get sent {
    return _sent;
  }
  
  const SpecialEvent._internal({required this.id, required eventId, required timeSubmitted, event, warned, sent}): _eventId = eventId, _timeSubmitted = timeSubmitted, _event = event, _warned = warned, _sent = sent;
  
  factory SpecialEvent({String? id, required String eventId, required TemporalDateTime timeSubmitted, Event? event, bool? warned, bool? sent}) {
    return SpecialEvent._internal(
      id: id == null ? UUID.getUUID() : id,
      eventId: eventId,
      timeSubmitted: timeSubmitted,
      event: event,
      warned: warned,
      sent: sent);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SpecialEvent &&
      id == other.id &&
      _eventId == other._eventId &&
      _timeSubmitted == other._timeSubmitted &&
      _event == other._event &&
      _warned == other._warned &&
      _sent == other._sent;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("SpecialEvent {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("eventId=" + "$_eventId" + ", ");
    buffer.write("timeSubmitted=" + (_timeSubmitted != null ? _timeSubmitted!.format() : "null") + ", ");
    buffer.write("warned=" + (_warned != null ? _warned!.toString() : "null") + ", ");
    buffer.write("sent=" + (_sent != null ? _sent!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  SpecialEvent copyWith({String? id, String? eventId, TemporalDateTime? timeSubmitted, Event? event, bool? warned, bool? sent}) {
    return SpecialEvent(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      timeSubmitted: timeSubmitted ?? this.timeSubmitted,
      event: event ?? this.event,
      warned: warned ?? this.warned,
      sent: sent ?? this.sent);
  }
  
  SpecialEvent.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _eventId = json['eventId'],
      _timeSubmitted = json['timeSubmitted'] != null ? TemporalDateTime.fromString(json['timeSubmitted']) : null,
      _event = json['event']?['serializedData'] != null
        ? Event.fromJson(new Map<String, dynamic>.from(json['event']['serializedData']))
        : null,
      _warned = json['warned'],
      _sent = json['sent'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'eventId': _eventId, 'timeSubmitted': _timeSubmitted?.format(), 'event': _event?.toJson(), 'warned': _warned, 'sent': _sent
  };

  static final QueryField ID = QueryField(fieldName: "specialEvent.id");
  static final QueryField EVENTID = QueryField(fieldName: "eventId");
  static final QueryField TIMESUBMITTED = QueryField(fieldName: "timeSubmitted");
  static final QueryField EVENT = QueryField(
    fieldName: "event",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Event).toString()));
  static final QueryField WARNED = QueryField(fieldName: "warned");
  static final QueryField SENT = QueryField(fieldName: "sent");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "SpecialEvent";
    modelSchemaDefinition.pluralName = "SpecialEvents";
    
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
      key: SpecialEvent.EVENTID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: SpecialEvent.TIMESUBMITTED,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: SpecialEvent.EVENT,
      isRequired: false,
      ofModelName: (Event).toString(),
      associatedKey: Event.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: SpecialEvent.WARNED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: SpecialEvent.SENT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
  });
}

class _SpecialEventModelType extends ModelType<SpecialEvent> {
  const _SpecialEventModelType();
  
  @override
  SpecialEvent fromJson(Map<String, dynamic> jsonData) {
    return SpecialEvent.fromJson(jsonData);
  }
}