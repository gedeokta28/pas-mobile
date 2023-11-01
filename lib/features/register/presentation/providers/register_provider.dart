import 'package:dio/dio.dart';
import 'package:pas_mobile/core/utility/enum.dart';
import 'package:pas_mobile/core/utility/extensions.dart';
import 'package:pas_mobile/features/register/domain/usecases/do_register.dart';
import 'package:pas_mobile/features/register/presentation/providers/register_state.dart';

import '../../../../core/presentation/form_provider.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/injection.dart';
import '../../../../core/utility/session_helper.dart';

class RegisterProvider extends FormProvider {
  final DoRegister doRegister;
  final session = locator<Session>();
  String _dropdownValue = AccountType.personal.getValue();
  String get dropdownValue => _dropdownValue;
  set dropdownValue(String value) {
    _dropdownValue = value;
    notifyListeners();
  }

  RegisterProvider({required this.doRegister});

  Stream<RegisterState> doRegisterApi() async* {
    showLoading();
    yield RegisterLoading();
    FormData formData;
    if (npwpController.text.isEmpty) {
      formData = FormData.fromMap({
        'customername': usernameController.text,
        'account_type': _dropdownValue,
        'noktp': ktpController.text,
        'contactperson': contactPersonController.text,
        'phone': phoneNumberController.text,
        'email': emailController.text,
        'password': passwordController.text,
      });
    } else {
      formData = FormData.fromMap({
        'customername': usernameController.text,
        'account_type': _dropdownValue,
        'noktp': ktpController.text,
        'contactperson': contactPersonController.text,
        'phone': phoneNumberController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'npwp': npwpController.text,
      });
    }

    final loginResult = await doRegister.call(formData);
    yield* loginResult.fold((failure) async* {
      dismissLoading();
      logMe(failure.message);
      yield RegisterFailure(failure: failure);
    }, (result) async* {
      session.setToken = result.accessToken;
      session.setLoggedIn = true;
      dismissLoading();
      yield RegisterSuccess(data: result);
    });
  }
}
