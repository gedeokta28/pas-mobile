import 'package:dio/dio.dart';
import 'package:pas_mobile/core/domain/usecases/get_provinces_list.dart';
import 'package:pas_mobile/core/presentation/region_state.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/account/data/models/get_address_model.dart';
import 'package:pas_mobile/features/account/domain/usecases/do_create_address.dart';
import 'package:pas_mobile/features/account/domain/usecases/do_delete_address.dart';
import 'package:pas_mobile/features/account/domain/usecases/do_update_address.dart';
import 'package:pas_mobile/features/account/domain/usecases/get_address_list.dart';

import '../../../../core/data/models/provinces_model.dart';
import '../../../../core/presentation/form_provider.dart';
import 'create_address_state.dart';
import 'get_address_list_state.dart';

class ShippingAddressProvider extends FormProvider {
  // initial

  final GetProvincesList getProvincesList;
  final DoCreateAddress doCreateAdress;
  final GetAddressList getAddressList;
  final DoDeleteAddress doDeleteAddress;
  final DoUpdateAddress doUpdateAddress;
  late List<Province> _provinceList = [];
  late bool _isProvinceValidate = true;
  Province? _selectedProvince;

  //get
  List<Province> get provinceList => _provinceList;
  bool get isProvinceValidate => _isProvinceValidate;
  Province? get selectedProvince => _selectedProvince;

  //setter
  set setSelectedProvince(val) {
    _selectedProvince = val;
    notifyListeners();
  }

  set setProvinceValidate(val) {
    _isProvinceValidate = val;
    notifyListeners();
  }

  // constructor
  ShippingAddressProvider({
    required this.getProvincesList,
    required this.doCreateAdress,
    required this.getAddressList,
    required this.doDeleteAddress,
    required this.doUpdateAddress,
  });

  Stream<RegionState> fetchProvinceList() async* {
    yield RegionLoading();

    final result = await getProvincesList();
    yield* result.fold(
      (failure) async* {
        logMe("Error");
        yield RegionFailure(failure: failure);
      },
      (data) async* {
        logMe("Provinceee");
        _provinceList = data;

        notifyListeners();
        yield RegionProvinceLoaded(data: data);
      },
    );
  }

  Stream<RegionState> fetchProvinceListUpdate(String? provinceUpdate) async* {
    yield RegionLoading();

    final result = await getProvincesList();
    yield* result.fold(
      (failure) async* {
        logMe("Error");
        yield RegionFailure(failure: failure);
      },
      (data) async* {
        logMe("Provinceee");
        _provinceList = data;
        if (provinceUpdate != null) {
          int index =
              _provinceList.indexWhere((item) => item.name == provinceUpdate);
          _selectedProvince = _provinceList[index];
        }

        notifyListeners();
        yield RegionProvinceLoaded(data: data);
      },
    );
  }

  setAddressData(ShippingAddress shippingAddress) async {
    nameController.text = shippingAddress.fullname;
    phoneNumberController.text = shippingAddress.phone;
    regenciesController.text = shippingAddress.city;
    streetNameController.text = shippingAddress.streetAddress;
    detailAddressController.text = shippingAddress.addressDetail;
    notifyListeners();
  }

  Stream<CreateAdressState> createAddress() async* {
    showLoading();
    yield CreateAdressLoading();
    FormData formData = FormData.fromMap({
      'fullname': nameController.text,
      'phone': phoneNumberController.text,
      'province': _selectedProvince!.name,
      'city': regenciesController.text,
      'street_address': streetNameController.text,
      'address_detail': detailAddressController.text,
    });
    final updateResult = await doCreateAdress.execute(formData);
    yield* updateResult.fold((failure) async* {
      dismissLoading();

      logMe("failure.message ${failure.message}");
      yield CreateAdressFailure(failure: failure);
    }, (result) async* {
      dismissLoading();
      yield CreateAdressSuccess(data: result);
    });
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

  Stream<CreateAdressState> deleteAddress(String addressId) async* {
    showLoading();
    yield CreateAdressLoading();

    final updateResult = await doDeleteAddress.execute(addressId);
    yield* updateResult.fold((failure) async* {
      dismissLoading();

      logMe("failure.message ${failure.message}");
      yield CreateAdressFailure(failure: failure);
    }, (result) async* {
      dismissLoading();
      yield CreateAdressSuccess(data: result);
    });
  }

  Stream<CreateAdressState> updateAddress(String addressId) async* {
    showLoading();
    yield CreateAdressLoading();
    Map<String, String> body = {
      'fullname': nameController.text,
      'phone': phoneNumberController.text,
      'province': _selectedProvince!.name,
      'city': regenciesController.text,
      'street_address': streetNameController.text,
      'address_detail': detailAddressController.text,
    };
    final updateResult = await doUpdateAddress.execute(body, addressId);
    yield* updateResult.fold((failure) async* {
      dismissLoading();
      logMe("failure.message ${failure.message}");
      yield CreateAdressFailure(failure: failure);
    }, (result) async* {
      dismissLoading();
      yield CreateAdressSuccess(data: result);
    });
  }
}
