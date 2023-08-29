import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/notification/data/models/order_notif_response_model.dart';
import 'package:pas_mobile/features/notification/domain/repositories/notification_repository.dart';

import '../../../../core/error/failures.dart';

abstract class GetOrderNotificationUseCase<Type> {
  Future<Either<Failure, List<OrderNotif>>> call();
}

class GetOrderNotification implements GetOrderNotificationUseCase<String> {
  final NotificationRepository repository;

  GetOrderNotification({required this.repository});

  @override
  Future<Either<Failure, List<OrderNotif>>> call() async {
    final result = await repository.getOrderNotif();
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
