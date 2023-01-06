import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/home/data/models/brand_list_response_model.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../home/data/models/category_list_response_model.dart';

abstract class BrandState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BrandEmpty extends BrandState {}

class BrandLoading extends BrandState {}

class BrandLoaded extends BrandState {
  // final BrandList data;
  final List<BrandList> data;

  BrandLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class BrandFailure extends BrandState {
  final Failure failure;

  BrandFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
