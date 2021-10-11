import 'package:paymongo_sdk/src/src.dart';

/// Payment intent for CREDIT/DEBIT CARD.
extension PayMongoPaymentIntent on PayMongoSDK {
  Future<String?> retreivePaymentIntent(int id) async {
    if (id <= 0) {
      throw ArgumentError("ID must be greater than 0");
    }

    final options = PayMongoOptions(
      path: '/payment_intents/$id',
    );

    final response = await get(options);

    return response;
  }

  Future<PaymentIntentResponse> createPaymentIntent(
      PaymentIntentAttributes attributes) async {
    if (attributes.amount <= 100) {
      throw ArgumentError("Amount should be at least above P 100.00");
    }
    final options = PayMongoOptions(path: '/payment_intents', data: {
      'attributes': attributes.toMap(),
    });
    final response = await post<Map<String, dynamic>>(options);
    return PaymentIntentResponse.fromMap(response);
  }

  Future<PaymentIntentAttachResponse> attachToPaymentIntent(
    String id,
    PaymentIntentAttach data,
  ) async {
    if (id.isEmpty) {
      throw ArgumentError("Payment Method ID must not be empty");
    }
    final options = PayMongoOptions(
      path: '/payment_intents/$id/attach',
      data: {
        'attributes': data.toMap(),
      },
    );
    final response = await post<Map<String, dynamic>>(options);
    final result = PaymentIntentAttachResponse.fromMap(response);
    return result;
  }
}
