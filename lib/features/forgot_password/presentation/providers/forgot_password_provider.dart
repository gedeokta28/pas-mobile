import 'package:dio/dio.dart';

import '../../../../core/presentation/form_provider.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/injection.dart';
import '../../../../core/utility/session_helper.dart';
import '../../domain/usecases/do_forgot_pass.dart';
import 'forgot_password_state.dart';

class ForgotPasswordProvider extends FormProvider {
  final DoForgotPassword doForgotPassword;
  final session = locator<Session>();

  ForgotPasswordProvider({required this.doForgotPassword});

  Stream<ForgotPasswordState> doForgotPasswordApi() async* {
    showLoading();
    yield ForgotPasswordLoading();
    FormData formData = FormData.fromMap({
      'email': emailController.text,
    });

    final result = await doForgotPassword.call(formData);
    yield* result.fold((failure) async* {
      dismissLoading();
      logMe(failure.message);
      yield ForgotPasswordFailure(failure: failure);
    }, (result) async* {
      dismissLoading();
      yield ForgotPasswordSuccess(data: result);
    });
  }
}
