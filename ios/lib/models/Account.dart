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

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Account type in your schema. */
@immutable
class Account extends Model {
  static const classType = const _AccountModelType();
  final String id;
  final String? _userName;
  final String? _userFullName;
  final String? _executorName;
  final String? _executorEmail;
  final String? _customerId;
  final String? _subscriptionId;
  final bool? _transition;
  final String? _customerStatus;

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
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get userFullName {
    return _userFullName;
  }
  
  String get executorName {
    try {
      return _executorName!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get executorEmail {
    return _executorEmail;
  }
  
  String get customerId {
    try {
      return _customerId!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get subscriptionId {
    return _subscriptionId;
  }
  
  bool? get transition {
    return _transition;
  }
  
  String? get customerStatus {
    return _customerStatus;
  }
  
  const Account._internal({required this.id, required userName, userFullName, required executorName, executorEmail, required customerId, subscriptionId, transition, customerStatus}): _userName = userName, _userFullName = userFullName, _executorName = executorName, _executorEmail = executorEmail, _customerId = customerId, _subscriptionId = subscriptionId, _transition = transition, _customerStatus = customerStatus;
  
  factory Account({String? id, required String userName, String? userFullName, required String executorName, String? executorEmail, required String customerId, String? subscriptionId, bool? transition, String? customerStatus}) {
    return Account._internal(
      id: id == null ? UUID.getUUID() : id,
      userName: userName,
      userFullName: userFullName,
      executorName: executorName,
      executorEmail: executorEmail,
      customerId: customerId,
      subscriptionId: subscriptionId,
      transition: transition,
      customerStatus: customerStatus);
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
      _userFullName == other._userFullName &&
      _executorName == other._executorName &&
      _executorEmail == other._executorEmail &&
      _customerId == other._customerId &&
      _subscriptionId == other._subscriptionId &&
      _transition == other._transition &&
      _customerStatus == other._customerStatus;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Account {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userName=" + "$_userName" + ", ");
    buffer.write("userFullName=" + "$_userFullName" + ", ");
    buffer.write("executorName=" + "$_executorName" + ", ");
    buffer.write("executorEmail=" + "$_executorEmail" + ", ");
    buffer.write("customerId=" + "$_customerId" + ", ");
    buffer.write("subscriptionId=" + "$_subscriptionId" + ", ");
    buffer.write("transition=" + (_transition != null ? _transition!.toString() : "null") + ", ");
    buffer.write("customerStatus=" + "$_customerStatus");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Account copyWith({String? id, String? userName, String? userFullName, String? executorName, String? executorEmail, String? customerId, String? subscriptionId, bool? transition, String? customerStatus}) {
    return Account(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userFullName: userFullName ?? this.userFullName,
      executorName: executorName ?? this.executorName,
      executorEmail: executorEmail ?? this.executorEmail,
      customerId: customerId ?? this.customerId,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      transition: transition ?? this.transition,
      customerStatus: customerStatus ?? this.customerStatus);
  }
  
  Account.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userName = json['userName'],
      _userFullName = json['userFullName'],
      _executorName = json['executorName'],
      _executorEmail = json['executorEmail'],
      _customerId = json['customerId'],
      _subscriptionId = json['subscriptionId'],
      _transition = json['transition'],
      _customerStatus = json['customerStatus'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userName': _userName, 'userFullName': _userFullName, 'executorName': _executorName, 'executorEmail': _executorEmail, 'customerId': _customerId, 'subscriptionId': _subscriptionId, 'transition': _transition, 'customerStatus': _customerStatus
  };

  static final QueryField ID = QueryField(fieldName: "account.id");
  static final QueryField USERNAME = QueryField(fieldName: "userName");
  static final QueryField USERFULLNAME = QueryField(fieldName: "userFullName");
  static final QueryField EXECUTORNAME = QueryField(fieldName: "executorName");
  static final QueryField EXECUTOREMAIL = QueryField(fieldName: "executorEmail");
  static final QueryField CUSTOMERID = QueryField(fieldName: "customerId");
  static final QueryField SUBSCRIPTIONID = QueryField(fieldName: "subscriptionId");
  static final QueryField TRANSITION = QueryField(fieldName: "transition");
  static final QueryField CUSTOMERSTATUS = QueryField(fieldName: "customerStatus");
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
      key: Account.USERFULLNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Account.EXECUTORNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Account.EXECUTOREMAIL,
      isRequired: false,
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Account.TRANSITION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Account.CUSTOMERSTATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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