import 'package:intervew_task/core/network/api_client.dart';
import 'package:intervew_task/features/home/data/models/dashboard_response_model.dart';

abstract class HomeRemoteDataSource {
  Future<DashboardResponseModel> getDashboardData();
  Future<void> saveLocation({
    required double latitude,
    required double longitude,
    required String address,
    String? city,
    String? countryCode,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImpl(this.apiClient);

  @override
  Future<DashboardResponseModel> getDashboardData() async {
    try {
      final response = await apiClient.dio.get('user/dashboard/');
      if (response.statusCode == 200) {
        // Safely convert the response data to Map<String, dynamic>
        final Map<String, dynamic> jsonData = 
            Map<String, dynamic>.from(response.data as Map);
        return DashboardResponseModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load dashboard data: ${response.statusCode}');
      }
    } catch (e) {
      // Printing the error helps identify if it's a parsing issue
      print('🌐 [Dashboard API Error]: $e');
      throw Exception('Error fetching dashboard: $e');
    }
  }

  @override
  Future<void> saveLocation({
    required double latitude,
    required double longitude,
    required String address,
    String? city,
    String? countryCode,
  }) async {
    try {
      await apiClient.dio.patch(
        'user/location/update/',
        data: {
          'latitude': latitude.toStringAsFixed(6),
          'longitude': longitude.toStringAsFixed(6),
          'address': address,
          if (city != null) 'city': city,
          if (countryCode != null) 'country_code': countryCode,
        },
      );
    } catch (e) {
      throw Exception('Error saving location: $e');
    }
  }
}
