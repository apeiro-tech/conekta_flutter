import 'package:flutter/foundation.dart';

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

  Map<String, dynamic> get toMap => {
        'cardName': cardName,
        'cardNumber': cardNumber,
        'ccv': ccv,
        'expirationMonth': expirationMonth,
        'expirationYear': expirationYear,
      };
}
