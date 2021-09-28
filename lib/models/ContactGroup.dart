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
  final Contact? _contact;
  final Group? _group;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  Contact get contact {
    try {
      return _contact!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  Group get group {
    try {
      return _group!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  const ContactGroup._internal({required this.id, required contact, required group}): _contact = contact, _group = group;
  
  factory ContactGroup({String? id, required Contact contact, required Group group}) {
    return ContactGroup._internal(
      id: id == null ? UUID.getUUID() : id,
      contact: contact,
      group: group);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContactGroup &&
      id == other.id &&
      _contact == other._contact &&
      _group == other._group;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ContactGroup {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("contact=" + (_contact != null ? _contact!.toString() : "null") + ", ");
    buffer.write("group=" + (_group != null ? _group!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ContactGroup copyWith({String? id, Contact? contact, Group? group}) {
    return ContactGroup(
      id: id ?? this.id,
      contact: contact ?? this.contact,
      group: group ?? this.group);
  }
  
  ContactGroup.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _contact = json['contact']?['serializedData'] != null
        ? Contact.fromJson(new Map<String, dynamic>.from(json['contact']['serializedData']))
        : null,
      _group = json['group']?['serializedData'] != null
        ? Group.fromJson(new Map<String, dynamic>.from(json['group']['serializedData']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'contact': _contact?.toJson(), 'group': _group?.toJson()
  };

  static final QueryField ID = QueryField(fieldName: "contactGroup.id");
  static final QueryField CONTACT = QueryField(
    fieldName: "contact",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Contact).toString()));
  static final QueryField GROUP = QueryField(
    fieldName: "group",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Group).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ContactGroup";
    modelSchemaDefinition.pluralName = "ContactGroups";
    
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: ContactGroup.CONTACT,
      isRequired: true,
      targetName: "contactId",
      ofModelName: (Contact).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: ContactGroup.GROUP,
      isRequired: true,
      targetName: "groupId",
      ofModelName: (Group).toString()
    ));
  });
}

class _ContactGroupModelType extends ModelType<ContactGroup> {
  const _ContactGroupModelType();
  
  @override
  ContactGroup fromJson(Map<String, dynamic> jsonData) {
    return ContactGroup.fromJson(jsonData);
  }
}