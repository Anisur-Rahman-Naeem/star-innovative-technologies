import 'package:equatable/equatable.dart';

class LocationState extends Equatable {
  final String location;
  final bool showModal;
  final bool isLoading;
  final String? error;

  const LocationState({
    required this.location,
    required this.showModal,
    this.isLoading = false,
    this.error,
  });

  factory LocationState.initial() =>
      const LocationState(location: 'Gulshan, Dhaka', showModal: true);

  LocationState copyWith({
    String? location,
    bool? showModal,
    bool? isLoading,
    String? error,
  }) {
    return LocationState(
      location: location ?? this.location,
      showModal: showModal ?? this.showModal,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [location, showModal, isLoading, error];
}
