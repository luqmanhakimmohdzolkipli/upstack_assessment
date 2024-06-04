import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upstack_assessment/auth/bloc/login_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  bool get _loginValid => _loginKey.currentState!.validate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _loginKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please enter correct information to access the data',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 80),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isObscure,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 150),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            if (_loginValid) {
                              context.read<LoginBloc>().add(
                                LoginSubmit(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  context: context,
                                ),
                              );
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
