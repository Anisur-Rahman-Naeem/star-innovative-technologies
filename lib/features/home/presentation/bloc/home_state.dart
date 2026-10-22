import 'package:equatable/equatable.dart';
import 'package:intervew_task/features/home/data/models/dashboard_response_model.dart';

abstract class HomeState extends Equatable{
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  HomeLoaded({required this.dashboardResponseModel});

  final DashboardResponseModel dashboardResponseModel;

  @override
  List<Object?> get props => [dashboardResponseModel];
}

class HomeError extends HomeState {
  HomeError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}