import 'package:dio/dio.dart';

import '../../../../core/presentation/form_provider.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/injection.dart';
import '../../../../core/utility/session_helper.dart';
import '../../domain/usecases/do_login.dart';
import 'login_state.dart';

class LoginProvider extends FormProvider {
  final DoLogin doLogin;
  final session = locator<Session>();

  LoginProvider({required this.doLogin});

  Stream<LoginState> doLoginApi() async* {
    showLoading();
    yield LoginLoading();
    FormData formData = FormData.fromMap(
        {'email': emailController.text, 'password': passwordController.text});

    final loginResult = await doLogin.call(formData);
    yield* loginResult.fold((failure) async* {
      dismissLoading();
      logMe(failure.message);
      yield LoginFailure(failure: failure);
    }, (result) async* {
      session.setToken = result.accessToken;
      session.setLoggedIn = true;
      dismissLoading();
      yield LoginSuccess(data: result);
    });
  }
}
