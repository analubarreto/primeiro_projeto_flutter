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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
      ),
      home: TaskInherited(
        child: const InitialScreen(),
      ),
      initialRoute: '/',
      routes: {
        '/form': (newContext) => FormScreen(newContext),
      }
    );
  }
}