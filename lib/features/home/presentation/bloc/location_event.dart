import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable{
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class GetLocationRequested extends LocationEvent {}

class LocationModalDismissed extends LocationEvent{}