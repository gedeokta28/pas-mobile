import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/update_profile_response_model.dart';
import '../repositories/profile_repository.dart';

abstract class UpdateProfileUseCase<Type> {
  Future<Either<Failure, UpdateProfileResponse>> execute(
      Map<String, String> data);
}

class DoUpdateProfile implements UpdateProfileUseCase<String> {
  final ProfileRepository repository;

  DoUpdateProfile({required this.repository});

  @override
  Future<Either<Failure, UpdateProfileResponse>> execute(
      Map<String, String> data) async {
    final result = await repository.doUpdateProfile(data);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
