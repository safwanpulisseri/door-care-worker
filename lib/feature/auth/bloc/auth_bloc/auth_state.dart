part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final UserModel userModel;

  const AuthSuccessState({required this.userModel});
}

final class AuthRegistrationSuccessState extends AuthState {
  final dynamic data;
  const AuthRegistrationSuccessState({this.data});
}

final class AuthFailState extends AuthState {
  final String message;
  const AuthFailState({this.message = 'An error occurred'});
}
