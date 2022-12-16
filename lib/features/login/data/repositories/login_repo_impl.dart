import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/core/utility/helper.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_data_source.dart';
import '../models/login_data_model.dart';
import '../models/login_error_response_model.dart';

class LoginRepoImpl implements LoginRepository {
  final LoginDataSource dataSource;

  LoginRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, LoginDataModel>> doLogin(FormData formData) async {
    try {
      final data = await dataSource.doLogin(formData);
      return Right(data);
    } on DioError catch (e) {
      final _failure = handleErrorResponse(e);
      logMe("Failure Login Repo");
      return Left(_failure);
    }
  }

  Failure handleErrorResponse(DioError e) {
    try {
      final errorModel = LoginErrorResponseModel.fromJson(e.response?.data);
      return ServerFailure(message: errorModel.message);
    } catch (e) {
      return const ServerFailure();
    }
  }
}
