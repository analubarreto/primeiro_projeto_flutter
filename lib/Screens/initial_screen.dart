import 'package:flutter/material.dart';
import 'package:primeiro_projeto/data/task_inherited.dart';
import 'package:primeiro_projeto/components/task.dart';

import 'package:primeiro_projeto/Data/task_dao.dart';

import 'package:primeiro_projeto/Components/ListStates/empty.dart';
import 'package:primeiro_projeto/Components/ListStates/error.dart';

class InitialScreen extends StatefulWidget {

  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  Future<List<Task>> getTaskList() async {
    TaskDao taskDao = TaskDao();
    return await taskDao.findAll();
  }

  List<Task>? taskList;

  bool isListEmpty = true;

  @override
  void initState() {
    super.initState();
    getTaskList().then((value) {
      setState(() {
        taskList = value;
        isListEmpty = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskInherited = TaskInherited.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
      ),
      body: isListEmpty ? const EmptyState() : Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: ListView.builder(
          itemCount: taskList!.length,
          itemBuilder: (context, index) {
            final Task task = taskList![index];
            return task;
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/form');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}