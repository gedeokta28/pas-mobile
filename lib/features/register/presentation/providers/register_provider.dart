import 'package:dio/dio.dart';
import 'package:pas_mobile/features/register/domain/usecases/do_register.dart';
import 'package:pas_mobile/features/register/presentation/providers/register_state.dart';

import '../../../../core/presentation/form_provider.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/injection.dart';
import '../../../../core/utility/session_helper.dart';

class RegisterProvider extends FormProvider {
  final DoRegister doRegister;
  final session = locator<Session>();

  RegisterProvider({required this.doRegister});

  Stream<RegisterState> doRegisterApi() async* {
    showLoading();
    yield RegisterLoading();
    FormData formData = FormData.fromMap({
      'email': emailController.text,
      'username': usernameController.text,
      'password': passwordController.text
    });

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
