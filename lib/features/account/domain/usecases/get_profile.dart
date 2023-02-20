import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/profile_model.dart';
import '../repositories/profile_repository.dart';

class GetProfile {
  final ProfileRepository repository;

  GetProfile(this.repository);

  Future<Either<Failure, Profile>> call() {
    return repository.getProfile();
  }
}
