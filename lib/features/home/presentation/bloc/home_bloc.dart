import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intervew_task/features/home/data/repositories/home_repository_impl.dart';
import 'package:intervew_task/features/home/presentation/bloc/home_event.dart';
import 'package:intervew_task/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  final HomeRepository _homeRepository;

  HomeBloc({required HomeRepository homeRepository}) : _homeRepository = homeRepository, super(HomeInitial()) {
    on<GetDashboardDataRequested>(_onGetDashboardDataRequested);
  }

  Future<void>_onGetDashboardDataRequested(GetDashboardDataRequested event, Emitter<HomeState> emit,) async {
    emit(HomeLoading());
    try{
      final response = await _homeRepository.getDashboardData();
      emit(HomeLoaded(dashboardResponseModel: response));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}