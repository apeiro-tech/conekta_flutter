import 'package:flutter/foundation.dart';

/// ConektaCard that represents the user credit card
class ConektaCard {
  final String cardName;
  final String cardNumber;
  final String expirationMonth;
  final String expirationYear;
  final String ccv;

  ConektaCard({
    @required this.cardName,
    @required this.cardNumber,
    @required this.expirationMonth,
    @required this.expirationYear,
    @required this.ccv,
  });

  /// Convert ConektaCard on a HashMap
  Map<String, dynamic> get toMap => {
        'cardName': cardName,
        'cardNumber': cardNumber,
        'ccv': ccv,
        'expirationMonth': expirationMonth,
        'expirationYear': expirationYear,
      };
}
