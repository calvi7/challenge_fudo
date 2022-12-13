import 'package:bloc/bloc.dart';
import 'package:challenge_fudo/src/features/auth/data/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repository) : super(const AuthInitial(false)) {
    on<AuthLoginAttempted>(_onLoginAttempted);
    on<AuthUserLoggedOut>(_onUserLogout);
    on<AuthErrorOccurred>(_onErrorOccurred);
  }

  final AuthRepository _repository;

  Future<void> _onLoginAttempted(
    AuthLoginAttempted event,
    Emitter<AuthState> emit,
  ) async {
    final user = event.username;
    final pass = event.password;

    if (user.isEmpty) {
      add(AuthErrorOccurred("Username can't be empty"));
      return;
    }

    if (pass.isEmpty) {
      add(AuthErrorOccurred("Password can't be empty"));
      return;
    }

    emit(const AuthLoading());

    bool login = await _repository.login(username: user, password: pass);

    if (login) {
      emit(const UserAuthenticated());
    } else {
      emit(const AuthError("Invalid username or password"));
      emit(const AuthInitial(false));
    }
  }

  void _onUserLogout(AuthUserLoggedOut event, Emitter<AuthState> emit) {
    emit(const UserUnauthenticated());
    emit(const AuthInitial(false));
  }

  void _onErrorOccurred(AuthErrorOccurred event, Emitter<AuthState> emit) {
    emit(AuthError(event.message));
    emit(AuthInitial(state.isAuthenticated));
  }
}
