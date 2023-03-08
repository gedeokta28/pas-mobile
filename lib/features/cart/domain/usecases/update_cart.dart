import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/cart/domain/repositories/cart_repository.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/cart_response_model.dart';

abstract class UpdateCartUseCase<Type> {
  Future<Either<Failure, CartResponseModel>> call(
      Map<String, String> data, String cartId);
}

class DoUpdateCart implements UpdateCartUseCase<String> {
  final CartRepository repository;

  DoUpdateCart({required this.repository});

  @override
  Future<Either<Failure, CartResponseModel>> call(
      Map<String, String> data, String cartId) async {
    final result = await repository.updateCart(data, cartId);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
