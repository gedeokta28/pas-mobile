import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/create_address_response_model.dart';
import '../repositories/profile_repository.dart';

abstract class DeleteAddressUseCase<Type> {
  Future<Either<Failure, CreateAddressResponseModel>> execute(String addressId);
}

class DoDeleteAddress implements DeleteAddressUseCase<String> {
  final ProfileRepository repository;

  DoDeleteAddress({required this.repository});

  @override
  Future<Either<Failure, CreateAddressResponseModel>> execute(
      String addressId) async {
    final result = await repository.doDeleteAddress(addressId);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
