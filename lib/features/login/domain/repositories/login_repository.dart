import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/login_data_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginDataModel>> doLogin(FormData data);
}
