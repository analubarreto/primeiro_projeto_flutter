import 'package:flutter/material.dart';
import 'package:primeiro_projeto/screens/form_screen.dart';
import 'package:primeiro_projeto/screens/initial_screen.dart';
import 'package:primeiro_projeto/data/task_inherited.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TaskInherited(
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const InitialScreen());
          case '/form':
            return MaterialPageRoute(builder: (context) => const FormScreen());
          default:
            return MaterialPageRoute(builder: (context) => const InitialScreen());
        }
      },
    ),
    );
  }
}