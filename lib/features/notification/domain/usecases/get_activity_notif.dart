import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/notification/data/models/activity_notif_response_model.dart';
import 'package:pas_mobile/features/notification/domain/repositories/notification_repository.dart';

import '../../../../core/error/failures.dart';

abstract class GetActivityNotificationUseCase<Type> {
  Future<Either<Failure, List<ActivityNotif>>> call();
}

class GetActivityNotification
    implements GetActivityNotificationUseCase<String> {
  final NotificationRepository repository;

  GetActivityNotification({required this.repository});

  @override
  Future<Either<Failure, List<ActivityNotif>>> call() async {
    final result = await repository.getActivityNotif();
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
