import 'package:flutter/material.dart';

import '../../../../core/presentation/form_provider.dart';
import '../../../../core/utility/enum.dart';

class OrderProvider extends FormProvider {
  PaymentMethod? _paymentMethod;

  PaymentMethod? get paymentMethod => _paymentMethod;

  set setPaymentMethod(val) {
    _paymentMethod = val;
    notifyListeners();
  }
}
