import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/account/data/models/info_response_model.dart';

import '../../../../core/error/failures.dart';

abstract class InfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InfoInitial extends InfoState {}

class InfoLoading extends InfoState {}

class InfoLoaded extends InfoState {
  final InfoData data;

  InfoLoaded({required this.data});
}

class InfoFailure extends InfoState {
  final Failure failure;

  InfoFailure(this.failure);
  @override
  List<Object?> get props => [failure];
}
