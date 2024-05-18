part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}


class LoginEvent extends AuthEvent {
  final String userName;
  final String password;

  const LoginEvent({required this.userName, required this.password});
}