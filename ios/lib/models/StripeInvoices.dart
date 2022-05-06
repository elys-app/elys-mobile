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


/** This is an auto generated class representing the StripeInvoices type in your schema. */
@immutable
class StripeInvoices {
  final String? _date;
  final String? _amount_paid;
  final String? _invoice_number;

  String get date {
    try {
      return _date!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get amount_paid {
    try {
      return _amount_paid!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get invoice_number {
    try {
      return _invoice_number!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const StripeInvoices._internal({required date, required amount_paid, required invoice_number}): _date = date, _amount_paid = amount_paid, _invoice_number = invoice_number;
  
  factory StripeInvoices({required String date, required String amount_paid, required String invoice_number}) {
    return StripeInvoices._internal(
      date: date,
      amount_paid: amount_paid,
      invoice_number: invoice_number);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StripeInvoices &&
      _date == other._date &&
      _amount_paid == other._amount_paid &&
      _invoice_number == other._invoice_number;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("StripeInvoices {");
    buffer.write("date=" + "$_date" + ", ");
    buffer.write("amount_paid=" + "$_amount_paid" + ", ");
    buffer.write("invoice_number=" + "$_invoice_number");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  StripeInvoices copyWith({String? date, String? amount_paid, String? invoice_number}) {
    return StripeInvoices._internal(
      date: date ?? this.date,
      amount_paid: amount_paid ?? this.amount_paid,
      invoice_number: invoice_number ?? this.invoice_number);
  }
  
  StripeInvoices.fromJson(Map<String, dynamic> json)  
    : _date = json['date'],
      _amount_paid = json['amount_paid'],
      _invoice_number = json['invoice_number'];
  
  Map<String, dynamic> toJson() => {
    'date': _date, 'amount_paid': _amount_paid, 'invoice_number': _invoice_number
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "StripeInvoices";
    modelSchemaDefinition.pluralName = "StripeInvoices";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'date',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'amount_paid',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'invoice_number',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}