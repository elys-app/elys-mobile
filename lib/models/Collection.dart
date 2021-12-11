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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Collection type in your schema. */
@immutable
class Collection extends Model {
  static const classType = const _CollectionModelType();
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
  
  const Collection._internal({required this.id, required name, required contacts}): _name = name, _contacts = contacts;
  
  factory Collection({String? id, required String name, required List<ContactGroup> contacts}) {
    return Collection._internal(
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
    return other is Collection &&
      id == other.id &&
      _name == other._name &&
      DeepCollectionEquality().equals(_contacts, other._contacts);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Collection {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Collection copyWith({String? id, String? name, List<ContactGroup>? contacts}) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      contacts: contacts ?? this.contacts);
  }
  
  Collection.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _contacts = json['contacts'] is List
        ? (json['contacts'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ContactGroup.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'contacts': _contacts?.map((ContactGroup? e) => e?.toJson()).toList()
  };

  static final QueryField ID = QueryField(fieldName: "collection.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField CONTACTS = QueryField(
    fieldName: "contacts",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ContactGroup).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Collection";
    modelSchemaDefinition.pluralName = "Collections";
    
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
      key: Collection.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Collection.CONTACTS,
      isRequired: false,
      ofModelName: (ContactGroup).toString(),
      associatedKey: ContactGroup.COLLECTION
    ));
  });
}

class _CollectionModelType extends ModelType<Collection> {
  const _CollectionModelType();
  
  @override
  Collection fromJson(Map<String, dynamic> jsonData) {
    return Collection.fromJson(jsonData);
  }
}