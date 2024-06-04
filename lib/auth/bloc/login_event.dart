part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmit extends LoginEvent {
  const LoginSubmit({
    required this.email,
    required this.password,
    required this.context,
  });

  final String email;
  final String password;
  final BuildContext context;

  @override
  List<Object> get props => [email, password, context];
}