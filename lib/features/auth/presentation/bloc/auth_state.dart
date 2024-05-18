part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();  

  @override
  List<Object> get props => [];
}
class AuthInitial extends AuthState {}

class Loading extends AuthState{}



class Error extends AuthState{
  final String error;

  const Error({required this.error});
}

class LoginSuccess extends AuthState{



}