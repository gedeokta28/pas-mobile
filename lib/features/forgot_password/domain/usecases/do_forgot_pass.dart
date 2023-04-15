import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/forgot_password_model.dart';
import '../repositories/forgot_password_repository.dart';

abstract class ForgotPasswordUseCase<Type> {
  Future<Either<Failure, ForgotPasswordResponseModel>> call(FormData data);
}

class DoForgotPassword implements ForgotPasswordUseCase<String> {
  final ForgotPasswordRepository repository;

  DoForgotPassword({required this.repository});

  @override
  Future<Either<Failure, ForgotPasswordResponseModel>> call(
      FormData data) async {
    final result = await repository.doForgotPassword(data);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
