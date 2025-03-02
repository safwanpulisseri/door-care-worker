import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/user_model.dart';
import '../../data/repository/auth_repo.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  AuthBloc(this._authRepo) : super(AuthInitialState()) {
    on<CheckUserEvent>((event, emit) async {
      UserModel? userModel;
      await Future.delayed(const Duration(seconds: 2)).whenComplete(() async {
        userModel = await _authRepo.getUser();
      });
      if (userModel != null) {
        log("data found");
        emit(AuthSuccessState(userModel: userModel!));
      } else {
        log("no data found");
        emit(const AuthFailState());
      }
    });
    on<SignOutEvent>((event, emit) async {
      try {
        await _authRepo.signOut();
        emit(AuthSignedOutState());
      } catch (e) {
        emit(const AuthFailState());
      }
    });
    on<EmailSignInAuthEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        try {
          final UserModel userModel = await _authRepo.emailSignIn(
            email: event.email,
            password: event.password,
          );

          emit(AuthSuccessState(userModel: userModel));
        } catch (e) {
          log(e.toString());
          emit(
              const AuthFailState(message: 'An error occurred during sign in'));
        }
      },
    );

    on<AccountCreateAuthEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        try {
          var response = await _authRepo.userRegistration(
            name: event.name,
            password: event.password,
            email: event.email,
            mobile: event.mobile,
            experience: event.experience,
            district: event.district,
            service: event.service,
            idCardImage: event.idCardImage,
            profileImage: event.profileImage,
          );
          if (response.statusCode == 200) {
            emit(AuthRegistrationSuccessState(data: response.data));
          } else {
            emit(AuthFailState(
                message:
                    'Registration failed with status code ${response.statusCode}'));
            log('Registration failed: ${response.statusCode}');
            throw Exception('Registration failed');
          }
        } catch (e) {
          log(e.toString());
          emit(const AuthFailState(
              message: 'An error occurred during registration'));
        }
      },
    );
  }
}
