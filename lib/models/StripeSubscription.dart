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

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the StripeSubscription type in your schema. */
@immutable
class StripeSubscription {
  final String? _subscriptionId;
  final String? _clientSecret;

  String? get subscriptionId {
    return _subscriptionId;
  }
  
  String? get clientSecret {
    return _clientSecret;
  }
  
  const StripeSubscription._internal({subscriptionId, clientSecret}): _subscriptionId = subscriptionId, _clientSecret = clientSecret;
  
  factory StripeSubscription({String? subscriptionId, String? clientSecret}) {
    return StripeSubscription._internal(
      subscriptionId: subscriptionId,
      clientSecret: clientSecret);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StripeSubscription &&
      _subscriptionId == other._subscriptionId &&
      _clientSecret == other._clientSecret;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("StripeSubscription {");
    buffer.write("subscriptionId=" + "$_subscriptionId" + ", ");
    buffer.write("clientSecret=" + "$_clientSecret");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  StripeSubscription copyWith({String? subscriptionId, String? clientSecret}) {
    return StripeSubscription._internal(
      subscriptionId: subscriptionId ?? this.subscriptionId,
      clientSecret: clientSecret ?? this.clientSecret);
  }
  
  StripeSubscription.fromJson(Map<String, dynamic> json)  
    : _subscriptionId = json['subscriptionId'],
      _clientSecret = json['clientSecret'];
  
  Map<String, dynamic> toJson() => {
    'subscriptionId': _subscriptionId, 'clientSecret': _clientSecret
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "StripeSubscription";
    modelSchemaDefinition.pluralName = "StripeSubscriptions";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'subscriptionId',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'clientSecret',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}