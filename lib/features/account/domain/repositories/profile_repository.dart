import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/features/account/data/models/info_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/create_address_response_model.dart';
import '../../data/models/get_address_model.dart';
import '../../data/models/profile_model.dart';
import '../../data/models/update_profile_response_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile();
  Future<Either<Failure, InfoData>> getInfo();
  Future<Either<Failure, UpdateProfileResponse>> doUpdateProfile(
      Map<String, String> formData);
  Future<Either<Failure, CreateAddressResponseModel>> doCreateAddress(
      FormData formData);
  Future<Either<Failure, List<ShippingAddress>>> getAddressList();
  Future<Either<Failure, CreateAddressResponseModel>> doDeleteAddress(
      String addressId);
  Future<Either<Failure, CreateAddressResponseModel>> doUpdateAddress(
      Map<String, String> formData, String addressId);
}
