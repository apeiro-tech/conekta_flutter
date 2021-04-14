import 'package:flutter/foundation.dart';

/// ConektaCard that represents the user credit card
class ConektaCard {
  final String? cardName;
  final String? cardNumber;
  final String? expirationMonth;
  final String? expirationYear;
  final String? cvv;

  ConektaCard({
    @required this.cardName,
    @required this.cardNumber,
    @required this.expirationMonth,
    @required this.expirationYear,
    @required this.cvv,
  });

  /// Convert ConektaCard on a HashMap
  Map<String, dynamic> get toMap => {
    'cardName': cardName,
    'cardNumber': cardNumber,
    'cvv': cvv,
    'expirationMonth': expirationMonth,
    'expirationYear': expirationYear,
  };
}
