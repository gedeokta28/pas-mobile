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

extension AccountTypeString on AccountType {
  String getValue() {
    switch (this) {
      case AccountType.personal:
        return 'personal';
      case AccountType.company:
        return 'company';
    }
  }

  String toStrings() {
    switch (this) {
      case AccountType.personal:
        return 'Pribadi';
      case AccountType.company:
        return 'Perusahaan';
    }
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

extension StatusOrderString on StatusOrder {
  String getString() {
    switch (this) {
      case StatusOrder.paymentPending:
        return 'payment pending';
      case StatusOrder.processing:
        return 'processing';
      case StatusOrder.onDelivery:
        return 'on_delivery';
      case StatusOrder.cancelled:
        return 'cancelled';
      case StatusOrder.completed:
        return 'completed';
    }
  }

  String toValue() {
    switch (this) {
      case StatusOrder.paymentPending:
        return 'Payment Pending';
      case StatusOrder.processing:
        return 'Processing';
      case StatusOrder.onDelivery:
        return 'On Delivery';
      case StatusOrder.cancelled:
        return 'Cancelled';
      case StatusOrder.completed:
        return 'Completed';
    }
  }
}
