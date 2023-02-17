import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/utility/helper.dart';
import '../models/provinces_model.dart';
import '../models/regencies_model.dart';

abstract class RegionDataSource {
  Future<List<ProvincesModel>> getProvincesList();
  Future<List<RegenciesModel>> getRegenciesList(String provinceId);
}

class RegionDataSourceImplementation implements RegionDataSource {
  final Dio dio;

  RegionDataSourceImplementation({required this.dio});

  @override
  Future<List<ProvincesModel>> getProvincesList() async {
    String url =
        'https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json';

    try {
      final response = await dio.get(
        url,
        options: options(headers: null),
      );
      final model = provincesModelFromJson(jsonEncode(response.data));
      return model;
    } catch (e) {
      logMe("errorr");
      logMe(e);
      rethrow;
    }
  }

  @override
  Future<List<RegenciesModel>> getRegenciesList(String provinceId) async {
    String url =
        'https://www.emsifa.com/api-wilayah-indonesia/api/regencies/$provinceId.json';

    try {
      final response = await dio.get(
        url,
        options: options(headers: null),
      );
      final model = regenciesModelFromJson(jsonEncode(response.data));
      return model;
    } catch (e) {
      logMe("errorr");
      logMe(e);
      rethrow;
    }
  }
}
