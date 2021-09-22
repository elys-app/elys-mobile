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


/** This is an auto generated class representing the Content type in your schema. */
@immutable
class Content extends Model {
  static const classType = const _ContentModelType();
  final String id;
  final String? _dateSubmitted;
  final String? _description;
  final String? _name;
  final String? _type;
  final String? _bucket;
  final String? _region;
  final String? _key;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get dateSubmitted {
    try {
      return _dateSubmitted!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get description {
    try {
      return _description!;
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
  
  String get type {
    try {
      return _type!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get bucket {
    try {
      return _bucket!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get region {
    try {
      return _region!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get key {
    try {
      return _key!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  const Content._internal({required this.id, required dateSubmitted, required description, required name, required type, required bucket, required region, required key}): _dateSubmitted = dateSubmitted, _description = description, _name = name, _type = type, _bucket = bucket, _region = region, _key = key;
  
  factory Content({String? id, required String dateSubmitted, required String description, required String name, required String type, required String bucket, required String region, required String key}) {
    return Content._internal(
      id: id == null ? UUID.getUUID() : id,
      dateSubmitted: dateSubmitted,
      description: description,
      name: name,
      type: type,
      bucket: bucket,
      region: region,
      key: key);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Content &&
      id == other.id &&
      _dateSubmitted == other._dateSubmitted &&
      _description == other._description &&
      _name == other._name &&
      _type == other._type &&
      _bucket == other._bucket &&
      _region == other._region &&
      _key == other._key;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Content {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("dateSubmitted=" + "$_dateSubmitted" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("type=" + "$_type" + ", ");
    buffer.write("bucket=" + "$_bucket" + ", ");
    buffer.write("region=" + "$_region" + ", ");
    buffer.write("key=" + "$_key");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Content copyWith({String? id, String? dateSubmitted, String? description, String? name, String? type, String? bucket, String? region, String? key}) {
    return Content(
      id: id ?? this.id,
      dateSubmitted: dateSubmitted ?? this.dateSubmitted,
      description: description ?? this.description,
      name: name ?? this.name,
      type: type ?? this.type,
      bucket: bucket ?? this.bucket,
      region: region ?? this.region,
      key: key ?? this.key);
  }
  
  Content.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _dateSubmitted = json['dateSubmitted'],
      _description = json['description'],
      _name = json['name'],
      _type = json['type'],
      _bucket = json['bucket'],
      _region = json['region'],
      _key = json['key'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'dateSubmitted': _dateSubmitted, 'description': _description, 'name': _name, 'type': _type, 'bucket': _bucket, 'region': _region, 'key': _key
  };

  static final QueryField ID = QueryField(fieldName: "content.id");
  static final QueryField DATESUBMITTED = QueryField(fieldName: "dateSubmitted");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField BUCKET = QueryField(fieldName: "bucket");
  static final QueryField REGION = QueryField(fieldName: "region");
  static final QueryField KEY = QueryField(fieldName: "key");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Content";
    modelSchemaDefinition.pluralName = "Contents";
    
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
      key: Content.DATESUBMITTED,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Content.DESCRIPTION,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Content.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Content.TYPE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Content.BUCKET,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Content.REGION,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Content.KEY,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _ContentModelType extends ModelType<Content> {
  const _ContentModelType();
  
  @override
  Content fromJson(Map<String, dynamic> jsonData) {
    return Content.fromJson(jsonData);
  }
}