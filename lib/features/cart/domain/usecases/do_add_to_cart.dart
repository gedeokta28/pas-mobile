import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/features/cart/data/models/cart_response_model.dart';
import 'package:pas_mobile/features/cart/domain/repositories/cart_repository.dart';

import '../../../../core/error/failures.dart';

abstract class AddToCartUseCase<Type> {
  Future<Either<Failure, CartResponseModel>> execute(FormData formData);
}

class DoAddToCart implements AddToCartUseCase<String> {
  final CartRepository repository;

  DoAddToCart({required this.repository});

  @override
  Future<Either<Failure, CartResponseModel>> execute(FormData formData) async {
    final result = await repository.addToCart(formData);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
