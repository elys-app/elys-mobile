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


/** This is an auto generated class representing the ContactGroup type in your schema. */
@immutable
class ContactGroup extends Model {
  static const classType = const _ContactGroupModelType();
  final String id;
  final Contact? _contact;
  final Collection? _collection;

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
  
  Collection get collection {
    try {
      return _collection!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  const ContactGroup._internal({required this.id, required contact, required collection}): _contact = contact, _collection = collection;
  
  factory ContactGroup({String? id, required Contact contact, required Collection collection}) {
    return ContactGroup._internal(
      id: id == null ? UUID.getUUID() : id,
      contact: contact,
      collection: collection);
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
      _collection == other._collection;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ContactGroup {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("contact=" + (_contact != null ? _contact!.toString() : "null") + ", ");
    buffer.write("collection=" + (_collection != null ? _collection!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ContactGroup copyWith({String? id, Contact? contact, Collection? collection}) {
    return ContactGroup(
      id: id ?? this.id,
      contact: contact ?? this.contact,
      collection: collection ?? this.collection);
  }
  
  ContactGroup.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _contact = json['contact']?['serializedData'] != null
        ? Contact.fromJson(new Map<String, dynamic>.from(json['contact']['serializedData']))
        : null,
      _collection = json['collection']?['serializedData'] != null
        ? Collection.fromJson(new Map<String, dynamic>.from(json['collection']['serializedData']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'contact': _contact?.toJson(), 'collection': _collection?.toJson()
  };

  static final QueryField ID = QueryField(fieldName: "contactGroup.id");
  static final QueryField CONTACT = QueryField(
    fieldName: "contact",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Contact).toString()));
  static final QueryField COLLECTION = QueryField(
    fieldName: "collection",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Collection).toString()));
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
      key: ContactGroup.COLLECTION,
      isRequired: true,
      targetName: "collectionId",
      ofModelName: (Collection).toString()
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