import 'package:dartz/dartz.dart';
import 'package:pas_mobile/core/error/failures.dart';
import 'package:pas_mobile/features/login/domain/repositories/login_repository.dart';

abstract class UpdateFcmTokenUseCase<Type> {
  Future<Either<Failure, bool>> call(String token);
}

class UpdateFcmToken implements UpdateFcmTokenUseCase<bool> {
  final LoginRepository repository;

  UpdateFcmToken({required this.repository});
  @override
  Future<Either<Failure, bool>> call(String token) async {
    return await repository.updateDeviceToken(token);
  }
}
