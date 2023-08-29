import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/account/data/models/info_response_model.dart';

import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

class GetInfo {
  final ProfileRepository repository;

  GetInfo(this.repository);

  Future<Either<Failure, InfoData>> call() {
    return repository.getInfo();
  }
}
