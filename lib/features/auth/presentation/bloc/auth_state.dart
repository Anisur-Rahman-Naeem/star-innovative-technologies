import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable{
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the app launches or before any auth action starts
class AuthInitial extends AuthState{}

/// Loading state emitted while login, register or OTP verification API calls are in progress
class AuthLoading extends AuthState {}

/// State emitted when authenticated, registered or verification succeeds
class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({this.token, this.errorMessage, this.message});

  final String? token;
  final String? errorMessage;
  final String? message;

  @override
  List<Object?> get props => [token, message];
}

/// State emitted when registration is successful and OTP code is required
class AuthOtpRequired extends AuthState {
  const AuthOtpRequired({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

/// Unauthenticated state (e.g. after logout or guest mode)
class AuthUnauthenticated extends AuthState {}

/// State emitted when any authentication operation fails
class AuthFailure extends AuthState {
  AuthFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}