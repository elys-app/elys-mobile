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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Contact type in your schema. */
@immutable
class Contact extends Model {
  static const classType = const _ContactModelType();
  final String id;
  final String? _name;
  final String? _email;
  final String? _relationship;
  final List<ContactGroup>? _group;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get name {
    return _name;
  }
  
  String get email {
    try {
      return _email!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String? get relationship {
    return _relationship;
  }
  
  List<ContactGroup>? get group {
    return _group;
  }
  
  const Contact._internal({required this.id, name, required email, relationship, group}): _name = name, _email = email, _relationship = relationship, _group = group;
  
  factory Contact({String? id, String? name, required String email, String? relationship, List<ContactGroup>? group}) {
    return Contact._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      email: email,
      relationship: relationship,
      group: group != null ? List<ContactGroup>.unmodifiable(group) : group);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Contact &&
      id == other.id &&
      _name == other._name &&
      _email == other._email &&
      _relationship == other._relationship &&
      DeepCollectionEquality().equals(_group, other._group);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Contact {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("relationship=" + "$_relationship");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Contact copyWith({String? id, String? name, String? email, String? relationship, List<ContactGroup>? group}) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      relationship: relationship ?? this.relationship,
      group: group ?? this.group);
  }
  
  Contact.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _email = json['email'],
      _relationship = json['relationship'],
      _group = json['group'] is List
        ? (json['group'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ContactGroup.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'email': _email, 'relationship': _relationship, 'group': _group?.map((e) => e?.toJson())?.toList()
  };

  static final QueryField ID = QueryField(fieldName: "contact.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField RELATIONSHIP = QueryField(fieldName: "relationship");
  static final QueryField GROUP = QueryField(
    fieldName: "group",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ContactGroup).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Contact";
    modelSchemaDefinition.pluralName = "Contacts";
    
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
      key: Contact.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Contact.EMAIL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Contact.RELATIONSHIP,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Contact.GROUP,
      isRequired: false,
      ofModelName: (ContactGroup).toString(),
      associatedKey: ContactGroup.ID
    ));
  });
}

class _ContactModelType extends ModelType<Contact> {
  const _ContactModelType();
  
  @override
  Contact fromJson(Map<String, dynamic> jsonData) {
    return Contact.fromJson(jsonData);
  }
}