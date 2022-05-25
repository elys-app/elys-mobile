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

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Account type in your schema. */
@immutable
class Account extends Model {
  static const classType = const _AccountModelType();
  final String id;
  final String? _userName;
  final String? _userEmail;
  final String? _userPhone;
  final String? _userFullName;
  final String? _executorName;
  final String? _executorEmail;
  final String? _executorId;
  final String? _customerId;
  final String? _subscriptionId;
  final bool? _transition;
  final bool? _basicAccount;
  final String? _customerStatus;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

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
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get userEmail {
    return _userEmail;
  }
  
  String? get userPhone {
    return _userPhone;
  }
  
  String? get userFullName {
    return _userFullName;
  }
  
  String get executorName {
    try {
      return _executorName!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get executorEmail {
    return _executorEmail;
  }
  
  String? get executorId {
    return _executorId;
  }
  
  String get customerId {
    try {
      return _customerId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
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
  
  bool? get basicAccount {
    return _basicAccount;
  }
  
  String? get customerStatus {
    return _customerStatus;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Account._internal({required this.id, required userName, userEmail, userPhone, userFullName, required executorName, executorEmail, executorId, required customerId, subscriptionId, transition, basicAccount, customerStatus, createdAt, updatedAt}): _userName = userName, _userEmail = userEmail, _userPhone = userPhone, _userFullName = userFullName, _executorName = executorName, _executorEmail = executorEmail, _executorId = executorId, _customerId = customerId, _subscriptionId = subscriptionId, _transition = transition, _basicAccount = basicAccount, _customerStatus = customerStatus, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Account({String? id, required String userName, String? userEmail, String? userPhone, String? userFullName, required String executorName, String? executorEmail, String? executorId, required String customerId, String? subscriptionId, bool? transition, bool? basicAccount, String? customerStatus}) {
    return Account._internal(
      id: id == null ? UUID.getUUID() : id,
      userName: userName,
      userEmail: userEmail,
      userPhone: userPhone,
      userFullName: userFullName,
      executorName: executorName,
      executorEmail: executorEmail,
      executorId: executorId,
      customerId: customerId,
      subscriptionId: subscriptionId,
      transition: transition,
      basicAccount: basicAccount,
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
      _userEmail == other._userEmail &&
      _userPhone == other._userPhone &&
      _userFullName == other._userFullName &&
      _executorName == other._executorName &&
      _executorEmail == other._executorEmail &&
      _executorId == other._executorId &&
      _customerId == other._customerId &&
      _subscriptionId == other._subscriptionId &&
      _transition == other._transition &&
      _basicAccount == other._basicAccount &&
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
    buffer.write("userEmail=" + "$_userEmail" + ", ");
    buffer.write("userPhone=" + "$_userPhone" + ", ");
    buffer.write("userFullName=" + "$_userFullName" + ", ");
    buffer.write("executorName=" + "$_executorName" + ", ");
    buffer.write("executorEmail=" + "$_executorEmail" + ", ");
    buffer.write("executorId=" + "$_executorId" + ", ");
    buffer.write("customerId=" + "$_customerId" + ", ");
    buffer.write("subscriptionId=" + "$_subscriptionId" + ", ");
    buffer.write("transition=" + (_transition != null ? _transition!.toString() : "null") + ", ");
    buffer.write("basicAccount=" + (_basicAccount != null ? _basicAccount!.toString() : "null") + ", ");
    buffer.write("customerStatus=" + "$_customerStatus" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Account copyWith({String? id, String? userName, String? userEmail, String? userPhone, String? userFullName, String? executorName, String? executorEmail, String? executorId, String? customerId, String? subscriptionId, bool? transition, bool? basicAccount, String? customerStatus}) {
    return Account._internal(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userPhone: userPhone ?? this.userPhone,
      userFullName: userFullName ?? this.userFullName,
      executorName: executorName ?? this.executorName,
      executorEmail: executorEmail ?? this.executorEmail,
      executorId: executorId ?? this.executorId,
      customerId: customerId ?? this.customerId,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      transition: transition ?? this.transition,
      basicAccount: basicAccount ?? this.basicAccount,
      customerStatus: customerStatus ?? this.customerStatus);
  }
  
  Account.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userName = json['userName'],
      _userEmail = json['userEmail'],
      _userPhone = json['userPhone'],
      _userFullName = json['userFullName'],
      _executorName = json['executorName'],
      _executorEmail = json['executorEmail'],
      _executorId = json['executorId'],
      _customerId = json['customerId'],
      _subscriptionId = json['subscriptionId'],
      _transition = json['transition'],
      _basicAccount = json['basicAccount'],
      _customerStatus = json['customerStatus'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userName': _userName, 'userEmail': _userEmail, 'userPhone': _userPhone, 'userFullName': _userFullName, 'executorName': _executorName, 'executorEmail': _executorEmail, 'executorId': _executorId, 'customerId': _customerId, 'subscriptionId': _subscriptionId, 'transition': _transition, 'basicAccount': _basicAccount, 'customerStatus': _customerStatus, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "account.id");
  static final QueryField USERNAME = QueryField(fieldName: "userName");
  static final QueryField USEREMAIL = QueryField(fieldName: "userEmail");
  static final QueryField USERPHONE = QueryField(fieldName: "userPhone");
  static final QueryField USERFULLNAME = QueryField(fieldName: "userFullName");
  static final QueryField EXECUTORNAME = QueryField(fieldName: "executorName");
  static final QueryField EXECUTOREMAIL = QueryField(fieldName: "executorEmail");
  static final QueryField EXECUTORID = QueryField(fieldName: "executorId");
  static final QueryField CUSTOMERID = QueryField(fieldName: "customerId");
  static final QueryField SUBSCRIPTIONID = QueryField(fieldName: "subscriptionId");
  static final QueryField TRANSITION = QueryField(fieldName: "transition");
  static final QueryField BASICACCOUNT = QueryField(fieldName: "basicAccount");
  static final QueryField CUSTOMERSTATUS = QueryField(fieldName: "customerStatus");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Account";
    modelSchemaDefinition.pluralName = "Accounts";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: AuthRuleProvider.USERPOOLS,
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
      key: Account.USEREMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Account.USERPHONE,
      isRequired: false,
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
      key: Account.EXECUTORID,
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
      key: Account.BASICACCOUNT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Account.CUSTOMERSTATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
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