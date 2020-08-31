import 'package:conekta_flutter/conekta_card.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:conekta_flutter/conekta_flutter.dart';

const _mockCardToken = 'src_1537821632272';
const _mockApiKey = 'apiKey_287362183';

void main() {
  const MethodChannel channel = MethodChannel('conekta_flutter');
  ConektaFlutter conektaFlutter;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'setApiKey') {
        return true;
      } else if (methodCall.method == 'onCreateCardToken') {
        return _mockCardToken;
      } else {
        return null;
      }
    });
    conektaFlutter = ConektaFlutter();
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
    conektaFlutter = null;
  });

  /// Unit test for setApiKey method
  test('setApiKey', () async {
    expect(
      await conektaFlutter.setApiKey(_mockApiKey),
      true,
    );
  });

  /// Unit test for createCardToken method
  test('createCardToken', () async {
    expect(
      await conektaFlutter.createCardToken(_getMockConektaCard()),
      _mockCardToken,
    );
  });
}

ConektaCard _getMockConektaCard() => ConektaCard(
      cardName: 'Alfonso Osorio',
      cardNumber: '42424242424242',
      expirationMonth: '12',
      expirationYear: '2020',
      cvv: '468',
    );
