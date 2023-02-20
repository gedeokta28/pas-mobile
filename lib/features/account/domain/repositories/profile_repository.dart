import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/profile_model.dart';
import '../../data/models/update_profile_response_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile();
  Future<Either<Failure, UpdateProfileResponse>> doUpdateProfile(
      Map<String, String> formData);
}
