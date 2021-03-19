import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:conekta_flutter/conekta_flutter.dart';
import 'package:conekta_flutter/conekta_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _token = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String token = "Unknown";
    try {
      ConektaFlutter conektaFlutter = ConektaFlutter();
      await conektaFlutter.setApiKey('key_CUfWMZnF5zvKyzPs2m897TQ');
      token = await conektaFlutter.createCardToken(ConektaCard(
        cardName: 'Alfonso Osorio',
        cardNumber: '4242424242424242',
        cvv: '847',
        expirationMonth: '12',
        expirationYear: '2040',
      ));
    } on PlatformException catch (exception) {
      token = exception.message;
    }

    if (!mounted) return;

    setState(() => _token = token);
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Conekta Flutter Plugin Example'),
          ),
          body: Center(
            child: Text('Conekta token: $_token\n'),
          ),
        ),
      );
}
