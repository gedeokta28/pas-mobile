import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/create_address_response_model.dart';
import '../repositories/profile_repository.dart';

abstract class CreateAddressUseCase<Type> {
  Future<Either<Failure, CreateAddressResponseModel>> execute(
      FormData formData);
}

class DoCreateAddress implements CreateAddressUseCase<String> {
  final ProfileRepository repository;

  DoCreateAddress({required this.repository});

  @override
  Future<Either<Failure, CreateAddressResponseModel>> execute(
      FormData formData) async {
    final result = await repository.doCreateAddress(formData);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
