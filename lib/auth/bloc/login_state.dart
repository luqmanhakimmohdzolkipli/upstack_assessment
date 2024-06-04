part of 'login_bloc.dart';

enum LoginStatus { initial, authenticated, unauthenticated }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
  });

  final LoginStatus status;

  LoginState copyWith({
    LoginStatus? status,
  }) {
    return LoginState(
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return '''LoginState { status: $status}''';
  }

  @override
  List<Object> get props => [status];
}