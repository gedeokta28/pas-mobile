import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/cart/domain/repositories/cart_repository.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/cart_response_model.dart';

abstract class DeleteCartUseCase<Type> {
  Future<Either<Failure, CartResponseModel>> execute(String cartId);
}

class DoDeleteCart implements DeleteCartUseCase<String> {
  final CartRepository repository;

  DoDeleteCart({required this.repository});

  @override
  Future<Either<Failure, CartResponseModel>> execute(String cartId) async {
    final result = await repository.deleteCart(cartId);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
