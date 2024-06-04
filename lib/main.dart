import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:upstack_assessment/list/view/list_view.dart';
import 'package:upstack_assessment/simple_bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upstack Assessment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListViews(),
    );
  }
}
