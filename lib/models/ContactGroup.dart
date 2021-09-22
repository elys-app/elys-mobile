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

/** This is an auto generated class representing the ContactGroup type in your schema. */
@immutable
class ContactGroup extends Model {
  static const classType = const _ContactGroupModelType();
  final String id;
  final Contact contact;
  final Group group;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const ContactGroup._internal({@required this.id, this.contact, this.group});

  factory ContactGroup({String id, Contact contact, Group group}) {
    return ContactGroup._internal(
        id: id == null ? UUID.getUUID() : id, contact: contact, group: group);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContactGroup &&
        id == other.id &&
        contact == other.contact &&
        group == other.group;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("ContactGroup {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write(
        "contact=" + (contact != null ? contact.toString() : "null") + ", ");
    buffer.write("group=" + (group != null ? group.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  ContactGroup copyWith({String id, Contact contact, Group group}) {
    return ContactGroup(
        id: id ?? this.id,
        contact: contact ?? this.contact,
        group: group ?? this.group);
  }

  ContactGroup.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        contact = json['contact'] != null
            ? Contact.fromJson(new Map<String, dynamic>.from(json['contact']))
            : null,
        group = json['group'] != null
            ? Group.fromJson(new Map<String, dynamic>.from(json['group']))
            : null;

  Map<String, dynamic> toJson() =>
      {'id': id, 'contact': contact?.toJson(), 'group': group?.toJson()};

  static final QueryField ID = QueryField(fieldName: "contactGroup.id");
  static final QueryField CONTACT = QueryField(
      fieldName: "contact",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Contact).toString()));
  static final QueryField GROUP = QueryField(
      fieldName: "group",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Group).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ContactGroup";
    modelSchemaDefinition.pluralName = "ContactGroups";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: ContactGroup.CONTACT,
        isRequired: false,
        targetName: "contactId",
        ofModelName: (Contact).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: ContactGroup.GROUP,
        isRequired: false,
        targetName: "groupId",
        ofModelName: (Group).toString()));
  });
}

class _ContactGroupModelType extends ModelType<ContactGroup> {
  const _ContactGroupModelType();

  @override
  ContactGroup fromJson(Map<String, dynamic> jsonData) {
    return ContactGroup.fromJson(jsonData);
  }
}
