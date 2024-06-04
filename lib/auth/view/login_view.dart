import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_signin_promax/github_signin_promax.dart';
import 'package:upstack_assessment/auth/bloc/login_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? clientId = dotenv.env['CLIENT_ID'];
  String? clientSecret = dotenv.env['CLIENT_SECRET'];
  late GithubSignInParams params;
  String response = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    params = GithubSignInParams(
      clientId: clientId ?? '',
      clientSecret: clientSecret ?? '',
      redirectUrl: 'http://localhost:3000/auth/github/callback',
      scopes: 'read:user,user:email',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(response),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (builder) {
                            return GithubSigninScreen(
                              params: params,
                            );
                          },
                        ),
                      ).then(
                        (value) {
                          String? token = (value as GithubSignInResponse).accessToken;
                          context.read<LoginBloc>().add(
                                LoginSubmit(
                                  token: token ?? '',
                                  context: context,
                                ),
                              );
                          setState(() {
                            response +=
                            '✅ Status: \t ${(value as GithubSignInResponse).status}\n\n';
                            response += '✅ Code: \t ${(value).accessToken}\n\n';
                            response += '✅ Error: \t ${(value).error}\n\n';
                          });
                        },
                      );
                    },
                    child: const Text('Login to Github'),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
