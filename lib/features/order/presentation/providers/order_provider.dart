import 'package:flutter/material.dart';

import '../../../../core/presentation/form_provider.dart';
import '../../../../core/utility/enum.dart';
import '../../../../core/utility/helper.dart';
import '../../../account/data/models/get_address_model.dart';
import '../../../account/domain/usecases/get_address_list.dart';
import '../../../account/presentation/providers/get_address_list_state.dart';

class OrderProvider extends FormProvider {
  final GetAddressList getAddressList;

  // constructor
  OrderProvider({
    required this.getAddressList,
  });

  PaymentMethod? _paymentMethod;
  ShippingAddress? _shippingAddressSelected;

  PaymentMethod? get paymentMethod => _paymentMethod;
  ShippingAddress? get shippingAddressSelected => _shippingAddressSelected;

  set setPaymentMethod(val) {
    _paymentMethod = val;
    notifyListeners();
  }

  set setShippingAddress(val) {
    _shippingAddressSelected = val;
    notifyListeners();
  }

  Stream<GetAddressListState> fetchAddressList() async* {
    yield GetAddressListLoading();

    final updateResult = await getAddressList();
    yield* updateResult.fold((failure) async* {
      logMe("failure.message ${failure.message}");
      yield GetAddressListFailure(failure: failure);
    }, (result) async* {
      yield GetAddressListSuccess(data: result);
    });
  }
}
