import 'dart:async';

import 'package:conekta_flutter/conekta_card.dart';
import 'package:flutter/services.dart';

const String _PLUGIN_NAME = 'conekta_flutter';
const String _SET_API_KEY_METHOD_NAME = 'setApiKey';
const String _ON_CREATE_CARD_TOKEN_NAME = 'onCreateCardToken';

class ConektaFlutter {
  static const MethodChannel _channel = const MethodChannel(_PLUGIN_NAME);

  Future<bool> setApiKey(String apiKey) =>
      _channel.invokeMethod(_SET_API_KEY_METHOD_NAME, {'apiKey': apiKey});

  Future<String> createCardToken(ConektaCard card) async {
    final String token =
        await _channel.invokeMethod(_ON_CREATE_CARD_TOKEN_NAME, card.toMap);
    return token;
  }
}
