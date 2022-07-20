part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLogin extends AuthEvent {
  final String username;
  final String phone;
  final String cite;
  final String weddingDate;

  const AuthLogin(this.username, this.phone, this.cite, this.weddingDate);
}
