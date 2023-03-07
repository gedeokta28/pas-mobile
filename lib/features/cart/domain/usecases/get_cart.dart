import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/features/cart/domain/repositories/cart_repository.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/cart_list_model.dart';

abstract class GetCartUseCase<Type> {
  Future<Either<Failure, List<ItemCart>>> call();
}

class GetCart implements GetCartUseCase<String> {
  final CartRepository repository;

  GetCart({required this.repository});

  @override
  Future<Either<Failure, List<ItemCart>>> call() async {
    final result = await repository.getCart();
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
