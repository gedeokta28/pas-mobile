import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/presentation/form_provider.dart';
import '../../../account/data/models/get_address_model.dart';
import '../../../account/domain/usecases/get_address_list.dart';
import 'shipping_address_state.dart';

class AddressCheckoutProvider extends FormProvider {
  final GetAddressList getAddressList;
  ShippingAddressListState _state = ShippingAddressListInitial();
  late List<ShippingAddress> _shipingAddressList;
  late List<ShippingAddress> _searchResult = [];
  bool _resultIsEmpty = false;

  // constructor
  AddressCheckoutProvider({
    required this.getAddressList,
  });

  set setState(val) {
    _state = val;
    notifyListeners();
  }

  set setShippingAddressList(val) {
    _shipingAddressList = val;
    notifyListeners();
  }

  set setSearchResult(val) {
    _searchResult = val;
    notifyListeners();
  }

  set setResultEmpty(val) {
    _resultIsEmpty = val;
    notifyListeners();
  }

  ShippingAddressListState get state => _state;
  List<ShippingAddress> get shipingAddressList => _shipingAddressList;
  List<ShippingAddress> get searchResult => _searchResult;
  bool get resultIsEmpty => _resultIsEmpty;

  Future<void> fetchAddressList() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState = ShippingAddressListLoading();

    late Either<Failure, List<ShippingAddress>> result;

    result = await getAddressList();
    await Future.delayed(const Duration(milliseconds: 500));
    result.fold(
      (failure) => setState = ShippingAddressListFailure(failure: failure),
      (data) {
        setShippingAddressList = data;
        if (data.isEmpty) {
          setState = ShippingAddressListEmpty();
        } else {
          setState = const ShippingAddressListSuccess();
        }
      },
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      notifyListeners();
      return;
    }

    for (var data in _shipingAddressList) {
      if (data.addressDetail.toLowerCase().contains(text) ||
          data.streetAddress.toLowerCase().contains(text) ||
          data.phone.toLowerCase().contains(text) ||
          data.fullname.toLowerCase().contains(text)) _searchResult.add(data);
    }

    if (_searchResult.isEmpty) {
      setResultEmpty = true;
    }
    notifyListeners();
  }
}
