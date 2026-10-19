import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../data/datasources/auth_remote_data_source.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthProvider({required this.authRemoteDataSource});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _token;
  String? get token => _token;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  String _extractErrorMessage(dynamic data, String defaultMessage) {
    if (data is Map) {
      try {
        final error = data['error'];
        if (error is Map) {
          return error['message']?.toString() ?? defaultMessage;
        }
        if (error != null) return error.toString();
        
        if (data['message'] != null) return data['message'].toString();
        if (data['detail'] != null) return data['detail'].toString();
        if (data['non_field_errors'] is List) {
          return (data['non_field_errors'] as List).join(', ');
        }
      } catch (_) {}
    }
    
    if (data is String) {
      if (data.contains('<!DOCTYPE html>') || data.contains('<html>')) {
        return defaultMessage;
      }
      return data;
    }

    return defaultMessage;
  }

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _setError(null);
    try {
      final res = await authRemoteDataSource.login(email, password);
      _token = res['token']?.toString();
      _setLoading(false);
      return true;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e.response?.data, 'Login failed. Please check your credentials.');
      _setError(message);
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred.');
      _setLoading(false);
      return false;
    }
  }

  Future<bool> register(String name, String email, String password, String confirmPassword) async {
    _setLoading(true);
    _setError(null);
    try {
      await authRemoteDataSource.register(name, email, password, confirmPassword);
      _setLoading(false);
      return true;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e.response?.data, 'Registration failed. Please try again.');
      _setError(message);
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred.');
      _setLoading(false);
      return false;
    }
  }

  Future<bool> verifyOtp(String email, String code) async {
    _setLoading(true);
    _setError(null);
    try {
      final res = await authRemoteDataSource.verifyOtp(email, code);
      _token = res['token']?.toString();
      _setLoading(false);
      return true;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e.response?.data, 'Invalid verification code.');
      _setError(message);
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred.');
      _setLoading(false);
      return false;
    }
  }
}
