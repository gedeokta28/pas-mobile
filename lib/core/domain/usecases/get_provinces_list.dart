import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/provinces_model.dart';
import '../repositories/region_repository.dart';

abstract class GetProvincesListUseCase<Type> {
  Future<Either<Failure, List<ProvincesModel>>> call();
}

class GetProvincesList implements GetProvincesListUseCase<String> {
  final RegionRepository repository;

  GetProvincesList({required this.repository});

  @override
  Future<Either<Failure, List<ProvincesModel>>> call() async {
    final result = await repository.getProvincesList();
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
