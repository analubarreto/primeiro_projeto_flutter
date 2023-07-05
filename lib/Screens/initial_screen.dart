
import 'package:flutter/material.dart';
import 'package:primeiro_projeto/data/task_inherited.dart';

class InitialScreen extends StatefulWidget {

  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Tarefas'),
      ),
      body: ListView(
        children: TaskInherited.of(context).taskList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<BuildContext> arguments = [context];
          Navigator.of(context).pushNamed('/form', arguments: arguments);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}