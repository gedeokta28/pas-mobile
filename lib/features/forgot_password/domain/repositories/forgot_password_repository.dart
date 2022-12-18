import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/forgot_password_model.dart';

abstract class ForgotPasswordRepository {
  Future<Either<Failure, ForgotPasswordResponseModel>> doForgotPassword(
      FormData data);
}
