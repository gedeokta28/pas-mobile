import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/core/utility/helper.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/forgot_password_repository.dart';
import '../datasources/forgot_password_data_source.dart';
import '../models/forgot_password_model.dart';
import '../models/forgot_password_error_model.dart';

class ForgotPasswordRepoImpl implements ForgotPasswordRepository {
  final ForgotPasswordDataSource dataSource;

  ForgotPasswordRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, ForgotPasswordResponseModel>> doForgotPassword(
      FormData formData) async {
    try {
      final data = await dataSource.doForgotPassword(formData);
      return Right(data);
    } on DioError catch (e) {
      final _failure = handleErrorResponse(e);
      logMe("Failure ForgotPassword Repo");
      return Left(_failure);
    }
  }

  Failure handleErrorResponse(DioError e) {
    try {
      final errorModel =
          ForgotPasswordErrorResponseModel.fromJson(e.response?.data);
      return ServerFailure(message: errorModel.errorMessage);
    } catch (e) {
      return const ServerFailure();
    }
  }
}
