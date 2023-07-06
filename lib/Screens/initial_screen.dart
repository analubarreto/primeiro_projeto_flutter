
import 'package:flutter/material.dart';
import 'package:primeiro_projeto/data/task_inherited.dart';
import 'package:primeiro_projeto/components/task.dart';

class InitialScreen extends StatefulWidget {

  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    final taskInherited = TaskInherited.of(context);
    List<Task> taskList = taskInherited.taskList;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(
                    color: Colors.deepPurple,
                    value: taskInherited.totalLevel / 100,
                  ),
                ),
                const SizedBox(width: 10),
                Text('${taskInherited.totalLevel.toStringAsFixed(2)}%'),
                IconButton(onPressed: () {
                  setState(() {
                    TaskInherited.of(context).calculateTotalLevel();
                  });
                }, icon: const Icon(Icons.refresh)),
              ],
            ),
          ],
        )
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        children: taskList,
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