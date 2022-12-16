import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pas_mobile/core/utility/session_helper.dart';
import 'package:pas_mobile/features/home/data/datasources/product_data_source.dart';
import 'package:pas_mobile/features/home/data/repositories/product_repo_impl.dart';
import 'package:pas_mobile/features/home/domain/repositories/product_repository.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_list.dart';
import 'package:pas_mobile/features/home/presentation/providers/home_provider.dart';
import 'package:pas_mobile/features/login/data/repositories/login_repo_impl.dart';
import 'package:pas_mobile/features/product/presentation/providers/app_bar_provider.dart';
import 'package:pas_mobile/features/register/data/datasources/register_data_source.dart';
import 'package:pas_mobile/features/register/data/repositories/register_repo_impl.dart';
import 'package:pas_mobile/features/register/domain/repositories/register_repository.dart';
import 'package:pas_mobile/features/register/domain/usecases/do_register.dart';
import 'package:pas_mobile/features/register/presentation/providers/register_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/login/data/datasources/login_data_source.dart';
import '../../features/login/domain/repositories/login_repository.dart';
import '../../features/login/domain/usecases/do_login.dart';
import '../../features/login/presentation/providers/login_provider.dart';
import '../../features/search/presentation/providers/search_provider.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';

late Locale myLocale;

late Session sessionHelper;
late bool isLoggedIn;

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));
  locator.registerLazySingleton<Dio>(() => DioClient().dio);
  locator.registerLazySingleton<Connectivity>(() => Connectivity());
  locator.registerLazySingletonAsync<Session>(() async =>
      SessionHelper(pref: await locator.getAsync<SharedPreferences>()));
  locator.registerLazySingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());
  locator.registerLazySingleton<GlobalKey<NavigatorState>>(
      () => GlobalKey<NavigatorState>());

//Providers
  locator.registerFactory<SearchProvider>(() => SearchProvider());
  locator
      .registerFactory<LoginProvider>(() => LoginProvider(doLogin: locator()));
  locator.registerFactory<RegisterProvider>(
      () => RegisterProvider(doRegister: locator()));
  locator.registerFactory<HomeProvider>(
      () => HomeProvider(getProductList: locator()));
  locator.registerFactory<AppBarProvider>(() => AppBarProvider());

//Datasource
  locator.registerLazySingleton<LoginDataSource>(
      () => LoginDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<RegisterDataSource>(
      () => RegisterDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<ProductDataSource>(
      () => ProductDataSourceImplementation(dio: locator()));

//Repository
  locator.registerLazySingleton<LoginRepository>(
      () => LoginRepoImpl(dataSource: locator()));
  locator.registerLazySingleton<RegisterRepository>(
      () => RegisterRepoImpl(dataSource: locator()));
  locator.registerLazySingleton<ProductRepsitory>(
      () => ProductRepoImpl(dataSource: locator()));

//Usecase
  locator.registerLazySingleton<DoLogin>(
      () => DoLogin(repository: locator(), session: locator()));
  locator.registerLazySingleton<DoRegister>(
      () => DoRegister(repository: locator(), session: locator()));
  locator.registerLazySingleton<GetProductList>(
      () => GetProductList(repository: locator()));
}
