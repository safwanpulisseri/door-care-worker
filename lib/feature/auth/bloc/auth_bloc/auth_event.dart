part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class CheckUserEvent extends AuthEvent {}

final class SignOutEvent extends AuthEvent {}

final class EmailSignInAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const EmailSignInAuthEvent({
    required this.email,
    required this.password,
  });
}

final class AccountCreateAuthEvent extends AuthEvent {
  final String name;
  final String password;
  final String email;
  final String mobile;
  final num experience;
  final String district;
  final String service;
  final String idCardImage;
  final String profileImage;

  const AccountCreateAuthEvent({
    required this.name,
    required this.password,
    required this.email,
    required this.mobile,
    required this.experience,
    required this.district,
    required this.service,
    required this.idCardImage,
    required this.profileImage,
  });
}
