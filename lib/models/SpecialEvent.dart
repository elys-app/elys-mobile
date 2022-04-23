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

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the SpecialEvent type in your schema. */
@immutable
class SpecialEvent extends Model {
  static const classType = const _SpecialEventModelType();
  final String id;
  final String? _bucket;
  final String? _region;
  final String? _key;
  final String? _executorEmail;
  final TemporalDateTime? _timeSubmitted;
  final bool? _warned;
  final bool? _sent;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get bucket {
    try {
      return _bucket!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get region {
    try {
      return _region!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get key {
    try {
      return _key!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get executorEmail {
    try {
      return _executorEmail!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime get timeSubmitted {
    try {
      return _timeSubmitted!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool? get warned {
    return _warned;
  }
  
  bool? get sent {
    return _sent;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const SpecialEvent._internal({required this.id, required bucket, required region, required key, required executorEmail, required timeSubmitted, warned, sent, createdAt, updatedAt}): _bucket = bucket, _region = region, _key = key, _executorEmail = executorEmail, _timeSubmitted = timeSubmitted, _warned = warned, _sent = sent, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory SpecialEvent({String? id, required String bucket, required String region, required String key, required String executorEmail, required TemporalDateTime timeSubmitted, bool? warned, bool? sent}) {
    return SpecialEvent._internal(
      id: id == null ? UUID.getUUID() : id,
      bucket: bucket,
      region: region,
      key: key,
      executorEmail: executorEmail,
      timeSubmitted: timeSubmitted,
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
      _bucket == other._bucket &&
      _region == other._region &&
      _key == other._key &&
      _executorEmail == other._executorEmail &&
      _timeSubmitted == other._timeSubmitted &&
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
    buffer.write("bucket=" + "$_bucket" + ", ");
    buffer.write("region=" + "$_region" + ", ");
    buffer.write("key=" + "$_key" + ", ");
    buffer.write("executorEmail=" + "$_executorEmail" + ", ");
    buffer.write("timeSubmitted=" + (_timeSubmitted != null ? _timeSubmitted!.format() : "null") + ", ");
    buffer.write("warned=" + (_warned != null ? _warned!.toString() : "null") + ", ");
    buffer.write("sent=" + (_sent != null ? _sent!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  SpecialEvent copyWith({String? id, String? bucket, String? region, String? key, String? executorEmail, TemporalDateTime? timeSubmitted, bool? warned, bool? sent}) {
    return SpecialEvent._internal(
      id: id ?? this.id,
      bucket: bucket ?? this.bucket,
      region: region ?? this.region,
      key: key ?? this.key,
      executorEmail: executorEmail ?? this.executorEmail,
      timeSubmitted: timeSubmitted ?? this.timeSubmitted,
      warned: warned ?? this.warned,
      sent: sent ?? this.sent);
  }
  
  SpecialEvent.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _bucket = json['bucket'],
      _region = json['region'],
      _key = json['key'],
      _executorEmail = json['executorEmail'],
      _timeSubmitted = json['timeSubmitted'] != null ? TemporalDateTime.fromString(json['timeSubmitted']) : null,
      _warned = json['warned'],
      _sent = json['sent'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'bucket': _bucket, 'region': _region, 'key': _key, 'executorEmail': _executorEmail, 'timeSubmitted': _timeSubmitted?.format(), 'warned': _warned, 'sent': _sent, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "specialEvent.id");
  static final QueryField BUCKET = QueryField(fieldName: "bucket");
  static final QueryField REGION = QueryField(fieldName: "region");
  static final QueryField KEY = QueryField(fieldName: "key");
  static final QueryField EXECUTOREMAIL = QueryField(fieldName: "executorEmail");
  static final QueryField TIMESUBMITTED = QueryField(fieldName: "timeSubmitted");
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
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: SpecialEvent.BUCKET,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: SpecialEvent.REGION,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: SpecialEvent.KEY,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: SpecialEvent.EXECUTOREMAIL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: SpecialEvent.TIMESUBMITTED,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
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