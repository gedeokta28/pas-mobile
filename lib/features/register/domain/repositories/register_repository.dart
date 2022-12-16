import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/register_data_model.dart';

abstract class RegisterRepository {
  Future<Either<Failure, RegisterDataModel>> doRegister(FormData data);
}
