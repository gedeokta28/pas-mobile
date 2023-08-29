import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/features/account/data/datasources/profile_datasource.dart';
import 'package:pas_mobile/features/account/data/models/info_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utility/helper.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/create_address_response_model.dart';
import '../models/error_update_profile.dart';
import '../models/get_address_model.dart';
import '../models/profile_model.dart';
import '../models/update_profile_response_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getProfile();
        return Right(result);
      } on DioError catch (e) {
        logMe(e);
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, InfoData>> getInfo() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getInfo();
        return Right(result);
      } on DioError catch (e) {
        logMe(e);
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UpdateProfileResponse>> doUpdateProfile(
      Map<String, String> formData) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.doUpdateProfile(formData);
        return Right(result);
      } on DioError catch (e) {
        final _failure = handleErrorResponse(e);
        logMe(e);
        return Left(_failure);
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  Failure handleErrorResponse(DioError e) {
    try {
      final errorModel =
          UpdateProfileErrorResponseModel.fromJson(e.response?.data);
      return ServerFailure(message: errorModel.errorMessage);
    } catch (e) {
      return const ServerFailure();
    }
  }

  @override
  Future<Either<Failure, CreateAddressResponseModel>> doCreateAddress(
      FormData formData) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.doCreateAddress(formData);
        return Right(result);
      } on DioError catch (e) {
        logMe(e);
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ShippingAddress>>> getAddressList() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getAddressList();
        return Right(result);
      } on DioError catch (e) {
        logMe(e);
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CreateAddressResponseModel>> doDeleteAddress(
      String addressId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.doDeleteAddress(addressId);
        return Right(result);
      } on DioError catch (e) {
        logMe(e);
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CreateAddressResponseModel>> doUpdateAddress(
      Map<String, String> formData, String addressId) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await remoteDataSource.doUpdateAddress(formData, addressId);
        return Right(result);
      } on DioError catch (e) {
        final _failure = handleErrorResponse(e);
        logMe(e);
        return Left(_failure);
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
