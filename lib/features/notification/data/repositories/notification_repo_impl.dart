import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/core/network/network_info.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/notification/data/datasources/notification_data_source.dart';
import 'package:pas_mobile/features/notification/data/models/activity_notif_response_model.dart';
import 'package:pas_mobile/features/notification/data/models/order_notif_response_model.dart';
import 'package:pas_mobile/features/notification/domain/repositories/notification_repository.dart';

import '../../../../core/error/failures.dart';

class NotificationRepoImpl implements NotificationRepository {
  final NotificationDataSource dataSource;
  final NetworkInfo networkInfo;

  NotificationRepoImpl({required this.dataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<ActivityNotif>>> getActivityNotif() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.getActivityNotif();
        return Right(result);
      } on DioError catch (e) {
        logMe(e);
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderNotif>>> getOrderNotif() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.getOrderNotif();
        return Right(result);
      } on DioError catch (e) {
        logMe(e);
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
