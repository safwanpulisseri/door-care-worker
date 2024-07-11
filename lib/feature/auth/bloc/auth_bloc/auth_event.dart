part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class SignInAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInAuthEvent({
    required this.email,
    required this.password,
  });
}

final class CreateWorkerAuthEvent extends AuthEvent {
  final String name;
  final String mobile;
  final String email;
  final String district;
  final String service;
  final int experience;
  final String password;
  final String confirmPassword;
  final String profileImage;
  final String idCardImage;
  const CreateWorkerAuthEvent({
    required this.name,
    required this.mobile,
    required this.email,
    required this.district,
    required this.service,
    required this.experience,
    required this.password,
    required this.confirmPassword,
    required this.profileImage,
    required this.idCardImage,
  });
}
