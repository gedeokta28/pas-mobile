import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/get_address_model.dart';
import '../repositories/profile_repository.dart';

abstract class GetAddressListUseCase<Type> {
  Future<Either<Failure, List<ShippingAddress>>> call();
}

class GetAddressList implements GetAddressListUseCase<String> {
  final ProfileRepository repository;

  GetAddressList({required this.repository});

  @override
  Future<Either<Failure, List<ShippingAddress>>> call() async {
    final result = await repository.getAddressList();
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
