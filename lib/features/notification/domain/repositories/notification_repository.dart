import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/notification/data/models/activity_notif_response_model.dart';
import 'package:pas_mobile/features/notification/data/models/order_notif_response_model.dart';

import '../../../../core/error/failures.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<ActivityNotif>>> getActivityNotif();
  Future<Either<Failure, List<OrderNotif>>> getOrderNotif();
}
