import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_starter/core/common/entities/user.dart';
import 'package:flutter_starter/core/usecase/usecase.dart';
import 'package:flutter_starter/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_starter/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_starter/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_starter/features/auth/domain/usecases/user_logout.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final UserLogout _userLogout;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required UserLogout userLogout,
    required AppUserCubit appUserCubit,
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       _currentUser = currentUser,
       _userLogout = userLogout,
       _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthInitial()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthLogout>(_onAuthLogout);
  }
  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
      UserLoginParams(email: event.email, password: event.password),
    );
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _userLogout();
      _appUserCubit.updateUser(null);
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure('Logout failed: \\${e.toString()}'));
    }
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
