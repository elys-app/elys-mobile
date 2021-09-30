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


/** This is an auto generated class representing the Group type in your schema. */
@immutable
class Group extends Model {
  static const classType = const _GroupModelType();
  final String id;
  final String? _name;
  final List<ContactGroup>? _contacts;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  List<ContactGroup> get contacts {
    try {
      return _contacts!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  const Group._internal({required this.id, required name, required contacts}): _name = name, _contacts = contacts;
  
  factory Group({String? id, required String name, required List<ContactGroup> contacts}) {
    return Group._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      contacts: contacts != null ? List<ContactGroup>.unmodifiable(contacts) : contacts);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Group &&
      id == other.id &&
      _name == other._name &&
      DeepCollectionEquality().equals(_contacts, other._contacts);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Group {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Group copyWith({String? id, String? name, List<ContactGroup>? contacts}) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      contacts: contacts ?? this.contacts);
  }
  
  Group.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _contacts = json['contacts'] is List
        ? (json['contacts'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ContactGroup.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'contacts': _contacts?.map((e) => e?.toJson())?.toList()
  };

  static final QueryField ID = QueryField(fieldName: "group.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField CONTACTS = QueryField(
    fieldName: "contacts",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ContactGroup).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Group";
    modelSchemaDefinition.pluralName = "Groups";
    
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
      key: Group.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Group.CONTACTS,
      isRequired: false,
      ofModelName: (ContactGroup).toString(),
      associatedKey: ContactGroup.ID
    ));
  });
}

class _GroupModelType extends ModelType<Group> {
  const _GroupModelType();
  
  @override
  Group fromJson(Map<String, dynamic> jsonData) {
    return Group.fromJson(jsonData);
  }
}