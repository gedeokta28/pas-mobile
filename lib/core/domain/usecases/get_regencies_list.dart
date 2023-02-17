import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/regencies_model.dart';
import '../repositories/region_repository.dart';

abstract class GetRegenciesListUseCase<Type> {
  Future<Either<Failure, List<RegenciesModel>>> call(String provinceId);
}

class GetRegenciesList implements GetRegenciesListUseCase<String> {
  final RegionRepository repository;

  GetRegenciesList({required this.repository});

  @override
  Future<Either<Failure, List<RegenciesModel>>> call(String provinceId) async {
    final result = await repository.getRegenciesList(provinceId);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
