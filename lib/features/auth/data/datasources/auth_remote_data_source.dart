import '../../../../core/network/api_client.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> register(String name, String email, String password, String confirmPassword);
  Future<Map<String, dynamic>> verifyOtp(String email, String code, {String deviceId = 'fcm_token_abc123xyz'});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  Map<String, dynamic> _handleResponse(dynamic data) {
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return {};
  }

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await apiClient.dio.post(
      'auth/login/',
      data: {'email': email, 'password': password},
    );
    return _handleResponse(response.data);
  }

  @override
  Future<Map<String, dynamic>> register(String name, String email, String password, String confirmPassword) async {
    final response = await apiClient.dio.post(
      'auth/sign-up/',
      data: {
        'full_name': name,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      },
    );
    return _handleResponse(response.data);
  }

  @override
  Future<Map<String, dynamic>> verifyOtp(String email, String code, {String deviceId = 'fcm_token_abc123xyz'}) async {
    final response = await apiClient.dio.post(
      'auth/sign-up/verify/',
      data: {
        'email': email,
        'otp': code,
        'device_id': deviceId,
      },
    );
    return _handleResponse(response.data);
  }
}
