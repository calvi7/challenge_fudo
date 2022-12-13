part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class AuthLoginAttempted extends AuthEvent {
  AuthLoginAttempted({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object?> get props => [username, password];
}

class AuthUserLoggedOut extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class AuthErrorOccurred extends AuthEvent {
  final String message;

  AuthErrorOccurred(this.message);

  @override
  List<Object?> get props => [message];
}
