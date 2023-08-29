import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/notification/data/models/activity_notif_response_model.dart';

import '../../../../core/error/failures.dart';

abstract class ActivityNotifState extends Equatable {
  final List<ActivityNotif>? data;

  const ActivityNotifState({this.data});
  @override
  List<Object?> get props => [];
}

class ActivityNotifInitial extends ActivityNotifState {}

class ActivityNotifLoading extends ActivityNotifState {}

class ActivityNotifEmpty extends ActivityNotifState {}

class ActivityNotifSuccess extends ActivityNotifState {
  // final DetailMotorBekasList data;
  const ActivityNotifSuccess({List<ActivityNotif>? data}) : super(data: data);

  @override
  List<Object?> get props => [data];
}

class ActivityNotifFailure extends ActivityNotifState {
  final Failure failure;

  const ActivityNotifFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
