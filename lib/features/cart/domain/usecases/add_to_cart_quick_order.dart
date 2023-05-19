import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/cart/data/models/cart_response_model.dart';
import 'package:pas_mobile/features/cart/domain/repositories/cart_repository.dart';

import '../../../../core/error/failures.dart';

abstract class AddToCartQuickOrderUseCase<Type> {
  Future<Either<Failure, CartResponseModel>> execute(dynamic productList);
}

class AddToCartQuickOrder implements AddToCartQuickOrderUseCase<String> {
  final CartRepository repository;

  AddToCartQuickOrder({required this.repository});

  @override
  Future<Either<Failure, CartResponseModel>> execute(
      dynamic productList) async {
    final result = await repository.addToCartQuickOrder(productList);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
