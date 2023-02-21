import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/create_address_response_model.dart';
import '../repositories/profile_repository.dart';

abstract class UpdateAddressUseCase<Type> {
  Future<Either<Failure, CreateAddressResponseModel>> execute(
      Map<String, String> formData, String addressId);
}

class DoUpdateAddress implements UpdateAddressUseCase<String> {
  final ProfileRepository repository;

  DoUpdateAddress({required this.repository});

  @override
  Future<Either<Failure, CreateAddressResponseModel>> execute(
      Map<String, String> formData, String addressId) async {
    final result = await repository.doUpdateAddress(formData, addressId);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
