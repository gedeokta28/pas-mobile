import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/core/utility/helper.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/register_repository.dart';
import '../datasources/register_data_source.dart';
import '../models/register_data_model.dart';
import '../models/register_error_response_model.dart';

class RegisterRepoImpl implements RegisterRepository {
  final RegisterDataSource dataSource;

  RegisterRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, RegisterDataModel>> doRegister(
      FormData formData) async {
    try {
      final data = await dataSource.doRegister(formData);
      return Right(data);
    } on DioError catch (e) {
      final _failure = handleErrorResponse(e);
      logMe("Failure Register Repo");
      return Left(_failure);
    }
  }

  Failure handleErrorResponse(DioError e) {
    try {
      final errorModel = RegisterErrorResponseModel.fromJson(e.response?.data);
      return ServerFailure(message: errorModel.errorMessage);
    } catch (e) {
      return const ServerFailure();
    }
  }
}
