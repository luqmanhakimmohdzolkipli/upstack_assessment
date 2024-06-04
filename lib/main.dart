import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upstack_assessment/auth/view/login_view.dart';
import 'package:upstack_assessment/list/view/list_view.dart';
import 'package:upstack_assessment/simple_bloc_observer.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  Bloc.observer = SimpleBlocObserver();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.prefs});

  final SharedPreferences prefs;
  
  @override
  Widget build(BuildContext context) {
    bool authenticated = prefs.getBool('authenticated') ?? false;
    return MaterialApp(
      title: 'Upstack Assessment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: authenticated ? const ListViews() : const LoginView(),
    );
  }
}
