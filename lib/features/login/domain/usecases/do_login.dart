import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utility/session_helper.dart';
import '../../data/models/login_data_model.dart';
import '../repositories/login_repository.dart';

abstract class LoginUseCase<Type> {
  Future<Either<Failure, LoginDataModel>> call(FormData data);
}

class DoLogin implements LoginUseCase<String> {
  final LoginRepository repository;
  final Session session;

  DoLogin({required this.repository, required this.session});

  @override
  Future<Either<Failure, LoginDataModel>> call(FormData data) async {
    final result = await repository.doLogin(data);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
