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
  final String userName;
  final String customerId;
  final String subscriptionId;
  final Contact executor;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Account._internal(
      {@required this.id,
      @required this.userName,
      @required this.customerId,
      this.subscriptionId,
      this.executor});

  factory Account(
      {String id,
      @required String userName,
      @required String customerId,
      String subscriptionId,
      Contact executor}) {
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
        userName == other.userName &&
        customerId == other.customerId &&
        subscriptionId == other.subscriptionId &&
        executor == other.executor;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Account {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userName=" + "$userName" + ", ");
    buffer.write("customerId=" + "$customerId" + ", ");
    buffer.write("subscriptionId=" + "$subscriptionId" + ", ");
    buffer
        .write("executor=" + (executor != null ? executor.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Account copyWith(
      {String id,
      String userName,
      String customerId,
      String subscriptionId,
      Contact executor}) {
    return Account(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        customerId: customerId ?? this.customerId,
        subscriptionId: subscriptionId ?? this.subscriptionId,
        executor: executor ?? this.executor);
  }

  Account.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userName = json['userName'],
        customerId = json['customerId'],
        subscriptionId = json['subscriptionId'],
        executor = json['executor'] != null
            ? Contact.fromJson(new Map<String, dynamic>.from(json['executor']))
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'customerId': customerId,
        'subscriptionId': subscriptionId,
        'executor': executor?.toJson()
      };

  static final QueryField ID = QueryField(fieldName: "account.id");
  static final QueryField USERNAME = QueryField(fieldName: "userName");
  static final QueryField CUSTOMERID = QueryField(fieldName: "customerId");
  static final QueryField SUBSCRIPTIONID =
      QueryField(fieldName: "subscriptionId");
  static final QueryField EXECUTOR = QueryField(
      fieldName: "executor",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Contact).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
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
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Account.CUSTOMERID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Account.SUBSCRIPTIONID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Account.EXECUTOR,
        isRequired: false,
        targetName: "executorId",
        ofModelName: (Contact).toString()));
  });
}

class _AccountModelType extends ModelType<Account> {
  const _AccountModelType();

  @override
  Account fromJson(Map<String, dynamic> jsonData) {
    return Account.fromJson(jsonData);
  }
}
