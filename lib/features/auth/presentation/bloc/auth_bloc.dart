import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intervew_task/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:intervew_task/features/auth/presentation/bloc/auth_event.dart';
import 'package:intervew_task/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final AuthRemoteDataSource authRemoteDataSource;

  AuthBloc({required this.authRemoteDataSource}): super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<VerifyOtpRequested>(_onVerifyOtpRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final res = await authRemoteDataSource.login(event.email, event.password);
      final token = res['token']?.toString();
      emit(AuthAuthenticated(token: token));
    } on DioException catch (e) {
      final message = _extractErrorMessage(e.response?.data, 'Login failed. Please check your credentials');
      emit(AuthFailure(errorMessage: message));
    } catch (e) {
      emit(AuthFailure(errorMessage: 'An unexpected error occurred'));
    }
  }

  Future<void> _onRegisterRequested(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRemoteDataSource.register(event.name, event.email, event.password, event.confirmPassword);
      emit(AuthOtpRequired(email: event.email));
    } on DioException catch (e) {
      final message = _extractErrorMessage(e.response?.data, 'Registration failed. Please try again');
      emit(AuthFailure(errorMessage: message));
    } catch (e) {
      emit(AuthFailure(errorMessage: 'An unexpected error occurred'));
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthUnauthenticated());
  }

  Future<void> _onVerifyOtpRequested(VerifyOtpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final res = await authRemoteDataSource.verifyOtp(event.email, event.code);
      final token = res['token']?.toString();
      emit(AuthAuthenticated(token: token, message: 'OTP Verified successfully'));
    } on DioException catch (e) {
      final message = _extractErrorMessage(e.response?.data, 'Invalid verification code');
      emit(AuthFailure(errorMessage: message));
    } catch (e) {
      emit(AuthFailure(errorMessage: 'An unexpected error occurred.'));
    }
  }

  String _extractErrorMessage(dynamic data, String defaultMessage) {
    if (data is Map){
      try {
        final error = data['error'];
        if (error is Map) {
          return error['message']?.toString() ?? defaultMessage;
        }
        if (error != null) return error.toString();

        if(data['message'] != null) return data['message'].toString();
        if(data['detail'] != null) return data['detail'].toString();
        if(data['non_field_errors'] is List) {
          return (data['non_field_errors'] as List).join(', ');
        }
      } catch (_){}
    }

    if(data is String) {
      if(data.contains('<!DOCTYPE html>') || data.contains('<html>')) {
        return defaultMessage;
      }
      return data;
    }

    return defaultMessage;
  }
}