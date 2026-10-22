import '../datasources/home_remote_data_source.dart';
import '../models/dashboard_response_model.dart';

abstract class HomeRepository {
  Future<DashboardResponseModel> getDashboardData();
  Future<void> saveLocation({
    required double latitude,
    required double longitude,
    required String address,
    String? city,
    String? countryCode,
  });
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DashboardResponseModel> getDashboardData() async {
    return await remoteDataSource.getDashboardData();
  }

  @override
  Future<void> saveLocation({
    required double latitude,
    required double longitude,
    required String address,
    String? city,
    String? countryCode,
  }) async {
    return await remoteDataSource.saveLocation(
      latitude: latitude,
      longitude: longitude,
      address: address,
      city: city,
      countryCode: countryCode,
    );
  }
}
