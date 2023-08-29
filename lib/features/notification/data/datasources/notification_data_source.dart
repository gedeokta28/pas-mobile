import 'package:dio/dio.dart';
import 'dart:io';
import 'package:pas_mobile/core/error/exception.dart';
import 'package:pas_mobile/core/utility/extensions.dart';
import 'package:pas_mobile/features/notification/data/models/activity_notif_response_model.dart';
import 'package:pas_mobile/features/notification/data/models/order_notif_response_model.dart';

abstract class NotificationDataSource {
  Future<List<ActivityNotif>> getActivityNotif();
  Future<List<OrderNotif>> getOrderNotif();
}

class NotificationDataSourceImpl implements NotificationDataSource {
  final Dio dio;

  NotificationDataSourceImpl({required this.dio});

  @override
  Future<List<ActivityNotif>> getActivityNotif() async {
    String path = 'api/notifications/activity';

    final response = await dio.get(path);

    if (response.statusCode == HttpStatus.ok) {
      final profileResponse =
          ActivityNotifResponseModel.fromJson(response.data);
      return profileResponse.data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<OrderNotif>> getOrderNotif() async {
    String path = 'api/notifications/transaction';
    dio.withToken();
    final response = await dio.get(path);

    if (response.statusCode == HttpStatus.ok) {
      final profileResponse = OrderNotifResponseModel.fromJson(response.data);
      return profileResponse.data;
    } else {
      throw ServerException();
    }
  }
}
