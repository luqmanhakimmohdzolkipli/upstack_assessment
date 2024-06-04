part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmit extends LoginEvent {
  const LoginSubmit({
    required this.token,
    required this.context,
  });

  final String token;
  final BuildContext context;

  @override
  List<Object> get props => [token, context];
}