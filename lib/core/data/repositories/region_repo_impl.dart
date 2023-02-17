import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/core/data/models/provinces_model.dart';
import 'package:pas_mobile/core/data/models/regencies_model.dart';
import 'package:pas_mobile/core/utility/helper.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/region_repository.dart';
import '../datasources/region_data_source.dart';

class RegionRepoImpl implements RegionRepository {
  final RegionDataSource dataSource;

  RegionRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<ProvincesModel>>> getProvincesList() async {
    try {
      final data = await dataSource.getProvincesList();
      return Right(data);
    } on DioError catch (e) {
      logMe("Failure Login Repo ${e.error}");
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<RegenciesModel>>> getRegenciesList(
      String provinceId) async {
    try {
      final data = await dataSource.getRegenciesList(provinceId);
      return Right(data);
    } on DioError catch (e) {
      logMe("Failure Login Repo ${e.error}");
      return const Left(ServerFailure());
    }
  }
}
