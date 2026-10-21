import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intervew_task/core/services/location_service.dart';
import 'package:intervew_task/features/home/presentation/bloc/location_event.dart';
import 'package:intervew_task/features/home/presentation/bloc/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState>{
  final LocationService _locationService;

  LocationBloc({required LocationService locationService})  : _locationService = locationService, super(LocationState.initial()) {
    on<GetLocationRequested>(_onGetLocationRequested);
    on<LocationModalDismissed>(_onLocationModalDismissed);
  }

  Future<void> _onGetLocationRequested(
      GetLocationRequested event,
    Emitter<LocationState> emit,) async{
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final position = await _locationService.getCurrentLocation();
      final address = await _locationService.getAddressFromLatLng(position);
      emit(state.copyWith(
        location: address,
        isLoading: false,
        showModal: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onLocationModalDismissed(LocationModalDismissed event, Emitter<LocationState> emit){
    emit(state.copyWith(showModal: false));
  }
}