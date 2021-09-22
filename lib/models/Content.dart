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
  final String dateSubmitted;
  final String description;
  final String name;
  final String type;
  final S3Object file;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Content._internal(
      {@required this.id,
      @required this.dateSubmitted,
      @required this.description,
      @required this.name,
      @required this.type,
      @required this.file});

  factory Content(
      {String id,
      @required String dateSubmitted,
      @required String description,
      @required String name,
      @required String type,
      @required S3Object file}) {
    return Content._internal(
        id: id == null ? UUID.getUUID() : id,
        dateSubmitted: dateSubmitted,
        description: description,
        name: name,
        type: type,
        file: file);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Content &&
        id == other.id &&
        dateSubmitted == other.dateSubmitted &&
        description == other.description &&
        name == other.name &&
        type == other.type &&
        file == other.file;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Content {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("dateSubmitted=" + "$dateSubmitted" + ", ");
    buffer.write("description=" + "$description" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("type=" + "$type" + ", ");
    buffer.write("file=" + (file != null ? file.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Content copyWith(
      {String id,
      String dateSubmitted,
      String description,
      String name,
      String type,
      S3Object file}) {
    return Content(
        id: id ?? this.id,
        dateSubmitted: dateSubmitted ?? this.dateSubmitted,
        description: description ?? this.description,
        name: name ?? this.name,
        type: type ?? this.type,
        file: file ?? this.file);
  }

  Content.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dateSubmitted = json['dateSubmitted'],
        description = json['description'],
        name = json['name'],
        type = json['type'],
        file = json['file'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'dateSubmitted': dateSubmitted,
        'description': description,
        'name': name,
        'type': type,
        'file': file
      };

  static final QueryField ID = QueryField(fieldName: "content.id");
  static final QueryField DATESUBMITTED =
      QueryField(fieldName: "dateSubmitted");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField FILE = QueryField(fieldName: "file");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
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
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Content.DESCRIPTION,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Content.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Content.TYPE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Content.FILE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _ContentModelType extends ModelType<Content> {
  const _ContentModelType();

  @override
  Content fromJson(Map<String, dynamic> jsonData) {
    return Content.fromJson(jsonData);
  }
}
