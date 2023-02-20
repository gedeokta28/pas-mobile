import 'package:dartz/dartz.dart';
import 'package:pas_mobile/core/data/models/provinces_model.dart';
import 'package:pas_mobile/core/data/models/regencies_model.dart';

import '../../../../core/error/failures.dart';

abstract class RegionRepository {
  Future<Either<Failure, List<Province>>> getProvincesList();
  Future<Either<Failure, List<RegenciesModel>>> getRegenciesList(
      String provinceId);
}
