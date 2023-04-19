import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

/// source response
class SourceAttributes extends Equatable {
  ///
  const SourceAttributes({
    required this.type,
    required this.amount,
    this.currency = 'PHP',
    required this.redirect,
    this.billing,
    required this.metadata,

  });

  ///
  factory SourceAttributes.fromMap(Map<String, dynamic> map) {
    return SourceAttributes(
      type: map['type'] ?? '',
      amount: (map['amount'] as num).toDouble(),
      currency: map['currency'] ?? '',
      redirect: Redirect.fromMap(map['redirect']),
      billing: map['billing'] != null ?PayMongoBilling.fromMap(map['billing']):null,
      metadata: map['metadata'],
    );
  }

  ///
  factory SourceAttributes.fromJson(String source) =>
      SourceAttributes.fromMap(json.decode(source));

  ///
  final String type;

  ///
  final double amount;

  ///
  final String currency;

  ///
  final Redirect redirect;

  ///
  final PayMongoBilling? billing;

  final Map<String,dynamic> metadata;


  ///
  SourceAttributes copyWith({
    String? type,
    double? amount,
    String? currency,
    Redirect? redirect,
    PayMongoBilling? billing,
    Map<String,dynamic>? metadata,
  }) {
    return SourceAttributes(
      type: type ?? this.type,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      redirect: redirect ?? this.redirect,
      billing: billing ?? this.billing,
      metadata: metadata ?? this.metadata,
    );
  }

  ///
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'amount': amount.toCurrency(),
      'currency': currency,
      'redirect': redirect.toMap(),
      if(billing !=null)'billing': billing?.toMap(),
      'metadata': metadata,
    };
  }

  ///
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props {
    return [
      type,
      amount,
      currency,
      redirect,
      billing,
    ];
  }
}
