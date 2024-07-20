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
          emit(AuthFailState());
        }
      },
    );

    on<AccountCreateAuthEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        try {
          final UserModel userModel = await _authRepo.userRegistration(
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

          emit(AuthSuccessState(userModel: userModel));
        } catch (e) {
          emit(AuthFailState());
        }
      },
    );
  }
}
