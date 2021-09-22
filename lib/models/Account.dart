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


/** This is an auto generated class representing the Account type in your schema. */
@immutable
class Account extends Model {
  static const classType = const _AccountModelType();
  final String id;
  final String? _userName;
  final String? _customerId;
  final String? _subscriptionId;
  final Contact? _executor;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get userName {
    try {
      return _userName!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get customerId {
    try {
      return _customerId!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String? get subscriptionId {
    return _subscriptionId;
  }
  
  Contact? get executor {
    return _executor;
  }
  
  const Account._internal({required this.id, required userName, required customerId, subscriptionId, executor}): _userName = userName, _customerId = customerId, _subscriptionId = subscriptionId, _executor = executor;
  
  factory Account({String? id, required String userName, required String customerId, String? subscriptionId, Contact? executor}) {
    return Account._internal(
      id: id == null ? UUID.getUUID() : id,
      userName: userName,
      customerId: customerId,
      subscriptionId: subscriptionId,
      executor: executor);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Account &&
      id == other.id &&
      _userName == other._userName &&
      _customerId == other._customerId &&
      _subscriptionId == other._subscriptionId &&
      _executor == other._executor;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Account {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userName=" + "$_userName" + ", ");
    buffer.write("customerId=" + "$_customerId" + ", ");
    buffer.write("subscriptionId=" + "$_subscriptionId" + ", ");
    buffer.write("executor=" + (_executor != null ? _executor!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Account copyWith({String? id, String? userName, String? customerId, String? subscriptionId, Contact? executor}) {
    return Account(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      customerId: customerId ?? this.customerId,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      executor: executor ?? this.executor);
  }
  
  Account.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userName = json['userName'],
      _customerId = json['customerId'],
      _subscriptionId = json['subscriptionId'],
      _executor = json['executor']?['serializedData'] != null
        ? Contact.fromJson(new Map<String, dynamic>.from(json['executor']['serializedData']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userName': _userName, 'customerId': _customerId, 'subscriptionId': _subscriptionId, 'executor': _executor?.toJson()
  };

  static final QueryField ID = QueryField(fieldName: "account.id");
  static final QueryField USERNAME = QueryField(fieldName: "userName");
  static final QueryField CUSTOMERID = QueryField(fieldName: "customerId");
  static final QueryField SUBSCRIPTIONID = QueryField(fieldName: "subscriptionId");
  static final QueryField EXECUTOR = QueryField(
    fieldName: "executor",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Contact).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Account";
    modelSchemaDefinition.pluralName = "Accounts";
    
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
      key: Account.USERNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Account.CUSTOMERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Account.SUBSCRIPTIONID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Account.EXECUTOR,
      isRequired: false,
      targetName: "executorId",
      ofModelName: (Contact).toString()
    ));
  });
}

class _AccountModelType extends ModelType<Account> {
  const _AccountModelType();
  
  @override
  Account fromJson(Map<String, dynamic> jsonData) {
    return Account.fromJson(jsonData);
  }
}