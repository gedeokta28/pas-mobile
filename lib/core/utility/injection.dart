import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pas_mobile/core/data/datasources/region_data_source.dart';
import 'package:pas_mobile/core/data/repositories/region_repo_impl.dart';
import 'package:pas_mobile/core/domain/repositories/region_repository.dart';
import 'package:pas_mobile/core/domain/usecases/get_provinces_list.dart';
import 'package:pas_mobile/core/domain/usecases/get_regencies_list.dart';
import 'package:pas_mobile/core/utility/session_helper.dart';
import 'package:pas_mobile/features/account/data/datasources/profile_datasource.dart';
import 'package:pas_mobile/features/account/data/repositories/profile_repository_impl.dart';
import 'package:pas_mobile/features/account/domain/repositories/profile_repository.dart';
import 'package:pas_mobile/features/account/domain/usecases/do_create_address.dart';
import 'package:pas_mobile/features/account/domain/usecases/do_delete_address.dart';
import 'package:pas_mobile/features/account/domain/usecases/do_update_address.dart';
import 'package:pas_mobile/features/account/domain/usecases/do_update_profile.dart';
import 'package:pas_mobile/features/account/domain/usecases/get_address_list.dart';
import 'package:pas_mobile/features/account/presentation/providers/management_account_provider.dart';
import 'package:pas_mobile/features/brand/presentation/providers/brand_provider.dart';
import 'package:pas_mobile/features/cart/data/datasources/cart_datasource.dart';
import 'package:pas_mobile/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:pas_mobile/features/cart/domain/repositories/cart_repository.dart';
import 'package:pas_mobile/features/cart/domain/usecases/delete_cart.dart';
import 'package:pas_mobile/features/cart/domain/usecases/do_add_to_cart.dart';
import 'package:pas_mobile/features/cart/domain/usecases/get_cart.dart';
import 'package:pas_mobile/features/cart/domain/usecases/update_cart.dart';
import 'package:pas_mobile/features/cart/presentation/providers/cart_provider.dart';
import 'package:pas_mobile/features/category/presentation/providers/category_provider.dart';
import 'package:pas_mobile/features/filter/presentation/providers/filter_provider.dart';
import 'package:pas_mobile/features/forgot_password/data/datasources/forgot_password_data_source.dart';
import 'package:pas_mobile/features/forgot_password/data/repositories/forgot_pass_repo_impl.dart';
import 'package:pas_mobile/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:pas_mobile/features/forgot_password/domain/usecases/do_forgot_pass.dart';
import 'package:pas_mobile/features/forgot_password/presentation/providers/forgot_password_provider.dart';
import 'package:pas_mobile/features/home/data/datasources/product_data_source.dart';
import 'package:pas_mobile/features/home/data/repositories/product_repo_impl.dart';
import 'package:pas_mobile/features/home/domain/repositories/product_repository.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_brand_list.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_category_list.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_detail.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_list.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_list_by_url.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_variant.dart';
import 'package:pas_mobile/features/home/presentation/providers/home_provider.dart';
import 'package:pas_mobile/features/login/data/repositories/login_repo_impl.dart';
import 'package:pas_mobile/features/notification/presentation/notification_provider.dart';
import 'package:pas_mobile/features/order/data/datasources/order_datasource.dart';
import 'package:pas_mobile/features/order/data/repositories/order_repository_impl.dart';
import 'package:pas_mobile/features/order/domain/repositories/order_repository.dart';
import 'package:pas_mobile/features/order/domain/usecase/create_order.dart';
import 'package:pas_mobile/features/order/domain/usecase/detail_order.dart';
import 'package:pas_mobile/features/order/domain/usecase/list_order.dart';
import 'package:pas_mobile/features/order/presentation/providers/order_provider.dart';
import 'package:pas_mobile/features/product/presentation/providers/app_bar_provider.dart';
import 'package:pas_mobile/features/product/presentation/providers/product_provider.dart';
import 'package:pas_mobile/features/product/presentation/providers/search_result_provider.dart';
import 'package:pas_mobile/features/quick_order/presentation/providers/quick_order_provider.dart';
import 'package:pas_mobile/features/register/data/datasources/register_data_source.dart';
import 'package:pas_mobile/features/register/data/repositories/register_repo_impl.dart';
import 'package:pas_mobile/features/register/domain/repositories/register_repository.dart';
import 'package:pas_mobile/features/register/domain/usecases/do_register.dart';
import 'package:pas_mobile/features/register/presentation/providers/register_provider.dart';
import 'package:pas_mobile/features/search/data/repositories/search_product_repo_impl.dart';
import 'package:pas_mobile/features/search/data/datasources/search_product_datasource.dart';
import 'package:pas_mobile/features/search/domain/repositories/search_product_repositories.dart';
import 'package:pas_mobile/features/search/domain/usecases/do_filter_product.dart';
import 'package:pas_mobile/features/search/domain/usecases/do_search_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/account/domain/usecases/get_profile.dart';
import '../../features/account/presentation/providers/shipping_address_provider.dart';
import '../../features/cart/domain/usecases/add_to_cart_quick_order.dart';
import '../../features/login/data/datasources/login_data_source.dart';
import '../../features/login/domain/repositories/login_repository.dart';
import '../../features/login/domain/usecases/do_login.dart';
import '../../features/login/presentation/providers/login_provider.dart';
import '../../features/order/presentation/providers/address_checkout_provider.dart';
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
  locator.registerFactory<SearchProvider>(() => SearchProvider(
      getProductList: locator(),
      doSearchProduct: locator(),
      doFilterProduct: locator()));
  locator
      .registerFactory<LoginProvider>(() => LoginProvider(doLogin: locator()));
  locator.registerFactory<RegisterProvider>(
      () => RegisterProvider(doRegister: locator()));
  locator.registerFactory<HomeProvider>(() => HomeProvider(
      getProductList: locator(),
      getCategoryList: locator(),
      doFilterProduct: locator()));
  locator.registerFactory<ProductProvider>(() => ProductProvider(
      getProductDetail: locator(),
      doFilterProduct: locator(),
      getProductVariant: locator()));
  locator.registerFactory<SearchResultProvider>(() => SearchResultProvider(
      getProductList: locator(), getCategoryList: locator()));
  locator.registerFactory<ForgotPasswordProvider>(
      () => ForgotPasswordProvider(doForgotPassword: locator()));
  locator.registerFactory<NotificationProvider>(() => NotificationProvider());
  locator.registerFactory<ManagementAccountProvider>(() =>
      ManagementAccountProvider(
          getProvincesList: locator(),
          getRegenciesList: locator(),
          doUpdateProfile: locator(),
          getProfile: locator()));
  locator
      .registerFactory<ShippingAddressProvider>(() => ShippingAddressProvider(
            getProvincesList: locator(),
            doCreateAdress: locator(),
            doDeleteAddress: locator(),
            getAddressList: locator(),
            doUpdateAddress: locator(),
          ));
  locator.registerFactory<CategoryProvider>(
      () => CategoryProvider(getCategoryList: locator()));
  locator.registerFactory<QuickOrderProvider>(() => QuickOrderProvider(
      getProductList: locator(),
      addToCartQuickOrder: locator(),
      doFilterProduct: locator(),
      getProductListByUrl: locator()));
  locator.registerFactory<BrandProvider>(
      () => BrandProvider(getBrandList: locator()));
  locator.registerFactory<FilterProvider>(
      () => FilterProvider(getCategoryList: locator()));
  locator.registerFactory<AppBarProvider>(
      () => AppBarProvider(getProductDetail: locator(), getCart: locator()));
  locator.registerFactory<CartProvider>(() => CartProvider(
      doDeleteCart: locator(),
      doAddToCart: locator(),
      getCart: locator(),
      doUpdateCart: locator()));
  locator.registerFactory<OrderProvider>(() => OrderProvider(
      getAddressList: locator(),
      getCart: locator(),
      doCreateOrder: locator(),
      getListOrder: locator(),
      getDetailOrder: locator()));
  locator
      .registerFactory<AddressCheckoutProvider>(() => AddressCheckoutProvider(
            getAddressList: locator(),
          ));

//Datasource
  locator.registerLazySingleton<LoginDataSource>(
      () => LoginDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<RegisterDataSource>(
      () => RegisterDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<ProductDataSource>(
      () => ProductDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<RegionDataSource>(
      () => RegionDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<ForgotPasswordDataSource>(
      () => ForgotPasswordDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<SearchProductDataSource>(
      () => SearchProductDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<ProfileDataSource>(
      () => ProfileDataSourceImpl(dio: locator()));
  locator.registerLazySingleton<CartDataSource>(
      () => CartDataSourceImpl(dio: locator()));
  locator.registerLazySingleton<OrderDataSource>(
      () => OrderDataSourceImpl(dio: locator()));

//Repository
  locator.registerLazySingleton<LoginRepository>(
      () => LoginRepoImpl(dataSource: locator()));
  locator.registerLazySingleton<RegisterRepository>(
      () => RegisterRepoImpl(dataSource: locator()));
  locator.registerLazySingleton<ProductRepsitory>(
      () => ProductRepoImpl(dataSource: locator()));
  locator.registerLazySingleton<RegionRepository>(
      () => RegionRepoImpl(dataSource: locator()));
  locator.registerLazySingleton<ForgotPasswordRepository>(
      () => ForgotPasswordRepoImpl(dataSource: locator()));
  locator.registerLazySingleton<SearchProductRepository>(
      () => SearchProductRepoImpl(dataSource: locator()));
  locator.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
      remoteDataSource: locator(), networkInfo: locator()));
  locator.registerLazySingleton<CartRepository>(() =>
      CartRepositoryImpl(remoteDataSource: locator(), networkInfo: locator()));
  locator.registerLazySingleton<OrderRepository>(() =>
      OrderRepositoryImpl(orderDataSource: locator(), networkInfo: locator()));

//Usecase
  locator.registerLazySingleton<DoLogin>(
      () => DoLogin(repository: locator(), session: locator()));
  locator.registerLazySingleton<DoRegister>(
      () => DoRegister(repository: locator(), session: locator()));
  locator.registerLazySingleton<GetProvincesList>(
      () => GetProvincesList(repository: locator()));
  locator.registerLazySingleton<GetRegenciesList>(
      () => GetRegenciesList(repository: locator()));
  locator.registerLazySingleton<GetProductList>(
      () => GetProductList(repository: locator()));
  locator.registerLazySingleton<GetProductListByUrl>(
      () => GetProductListByUrl(repository: locator()));
  locator.registerLazySingleton<GetProductDetail>(
      () => GetProductDetail(repository: locator()));
  locator.registerLazySingleton<GetCategoryList>(
      () => GetCategoryList(repository: locator()));
  locator.registerLazySingleton<GetBrandList>(
      () => GetBrandList(repository: locator()));
  locator.registerLazySingleton<DoForgotPassword>(
      () => DoForgotPassword(repository: locator()));
  locator.registerLazySingleton<DoSearchProduct>(
      () => DoSearchProduct(repository: locator()));
  locator.registerLazySingleton<DoFilterProduct>(
      () => DoFilterProduct(repository: locator()));
  locator.registerLazySingleton<GetProfile>(() => GetProfile(locator()));
  locator.registerLazySingleton<DoUpdateProfile>(
      () => DoUpdateProfile(repository: locator()));
  locator.registerLazySingleton<DoCreateAddress>(
      () => DoCreateAddress(repository: locator()));
  locator.registerLazySingleton<GetAddressList>(
      () => GetAddressList(repository: locator()));
  locator.registerLazySingleton<DoDeleteAddress>(
      () => DoDeleteAddress(repository: locator()));
  locator.registerLazySingleton<DoUpdateAddress>(
      () => DoUpdateAddress(repository: locator()));
  locator.registerLazySingleton<DoAddToCart>(
      () => DoAddToCart(repository: locator()));
  locator.registerLazySingleton<AddToCartQuickOrder>(
      () => AddToCartQuickOrder(repository: locator()));
  locator.registerLazySingleton<DoUpdateCart>(
      () => DoUpdateCart(repository: locator()));
  locator.registerLazySingleton<GetCart>(() => GetCart(repository: locator()));
  locator.registerLazySingleton<DoDeleteCart>(
      () => DoDeleteCart(repository: locator()));
  locator.registerLazySingleton<GetProductVariant>(
      () => GetProductVariant(repository: locator()));
  locator.registerLazySingleton<DoCreateOrder>(
      () => DoCreateOrder(repository: locator()));
  locator.registerLazySingleton<GetDetailOrder>(
      () => GetDetailOrder(repository: locator()));
  locator.registerLazySingleton<GetListOrder>(
      () => GetListOrder(repository: locator()));
}
