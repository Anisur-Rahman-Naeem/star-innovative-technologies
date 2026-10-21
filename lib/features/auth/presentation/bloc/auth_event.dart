import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  const LoginRequested({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  const RegisterRequested({required this.name, required this.email, required this.password, required this.confirmPassword});

  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  @override
  List<Object?> get props => [name, email, password, confirmPassword];
}

class VerifyOtpRequested extends AuthEvent {
  const VerifyOtpRequested({required this.email, required this.code});

  final String email;
  final String code;

  @override
  List<Object?> get props => [email, code];
}

class LogoutRequested extends AuthEvent {}