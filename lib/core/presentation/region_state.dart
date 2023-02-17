import 'package:equatable/equatable.dart';
import 'package:pas_mobile/core/data/models/provinces_model.dart';
import 'package:pas_mobile/core/data/models/regencies_model.dart';

import '../../../../core/error/failures.dart';

abstract class RegionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegionLoading extends RegionState {}

class RegionProvinceLoaded extends RegionState {
  // final RegionList data;
  final List<ProvincesModel> data;

  RegionProvinceLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class RegionRegenciesLoaded extends RegionState {
  // final RegionList data;
  final List<RegenciesModel> data;

  RegionRegenciesLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class RegionFailure extends RegionState {
  final Failure failure;

  RegionFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
