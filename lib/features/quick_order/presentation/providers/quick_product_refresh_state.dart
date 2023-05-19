import 'package:equatable/equatable.dart';

abstract class QuickProductRefreshState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuickProductRefreshInitial extends QuickProductRefreshState {}

class QuickProductRefreshLoading extends QuickProductRefreshState {}

class QuickProductRefreshLoaded extends QuickProductRefreshState {
  final List<dynamic> data;

  QuickProductRefreshLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class QuickProductRefreshFailure extends QuickProductRefreshState {}
