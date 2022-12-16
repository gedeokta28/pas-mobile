import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utility/session_helper.dart';
import '../../data/models/register_data_model.dart';
import '../repositories/register_repository.dart';

abstract class RegisterUseCase<Type> {
  Future<Either<Failure, RegisterDataModel>> call(FormData data);
}

class DoRegister implements RegisterUseCase<String> {
  final RegisterRepository repository;
  final Session session;

  DoRegister({required this.repository, required this.session});

  @override
  Future<Either<Failure, RegisterDataModel>> call(FormData data) async {
    final result = await repository.doRegister(data);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
