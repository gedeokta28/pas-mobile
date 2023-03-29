import 'package:dio/dio.dart';

import 'enum.dart';

extension DynamicHeader on Dio {
  Dio withToken() {
    return this..options.headers.addAll({'required_token': true});
  }

  Dio withFcmAuthorization(String key) {
    return this..options.headers.addAll({'Authorization': 'key=$key'});
  }
}

extension LocalizationString on PaymentMethod {
  String getString() {
    switch (this) {
      case PaymentMethod.cash:
        return 'Cash On Delivery';
      case PaymentMethod.trasnfer:
        return 'Transfer';
    }
  }
}
