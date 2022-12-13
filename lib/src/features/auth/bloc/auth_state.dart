part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final bool isAuthenticated;

  const AuthState(this.isAuthenticated);

  @override
  List<Object?> get props => [isAuthenticated];
}

class AuthInitial extends AuthState {
  const AuthInitial(super.isAuthenticated);
}

class AuthLoading extends AuthState {
  const AuthLoading() : super(false);
}

class AuthError extends AuthState {
  const AuthError(this.message) : super(false);

  final String message;
}

class UserAuthenticated extends AuthState {
  const UserAuthenticated() : super(true);
}

class UserUnauthenticated extends AuthState {
  const UserUnauthenticated() : super(false);
}
