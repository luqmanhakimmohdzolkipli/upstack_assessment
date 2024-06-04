import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upstack_assessment/list/view/list_view.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginSubmit>(_onLoginSubmit);
  }

  Future<void>  _onLoginSubmit(
    LoginSubmit event,
    Emitter<LoginState> emit,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (event.token.isNotEmpty) {
      emit(state.copyWith(status: LoginStatus.authenticated));
      await prefs.setString('token', event.token);
      await prefs.setBool('authenticated', true);
    }
    if (state.status == LoginStatus.authenticated) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => ListViews(),
        ),
      );
    }
  }
}
