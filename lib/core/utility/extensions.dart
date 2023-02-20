import 'package:dio/dio.dart';

extension DynamicHeader on Dio {
  Dio withToken() {
    return this..options.headers.addAll({'required_token': true});
  }

  Dio withFcmAuthorization(String key) {
    return this..options.headers.addAll({'Authorization': 'key=$key'});
  }
}
