
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
    bool isTaskListEmpty = taskList.isEmpty;


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
                  width: 180,
                  child: LinearProgressIndicator(
                    color: Colors.deepPurple,
                    value: isTaskListEmpty ? 0 : taskInherited.totalLevel / 100,
                  ),
                ),
                const SizedBox(width: 10),
                Text('${isTaskListEmpty ? 0 : taskInherited.totalLevel.toStringAsFixed(2)}%'),
                IconButton(onPressed: () {
                  setState(() {
                    TaskInherited.of(context).calculateTotalLevel();
                  });
                }, icon: const Icon(Icons.refresh),),
              ],
            ),
          ],
        )
      ),
      body: isTaskListEmpty ?
          const Card(
            child: Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.assignment_late, size: 100, color: Colors.redAccent,),
                  Text('Nenhuma tarefa cadastrada, clique no botão flutuante para cadastrar uma nova tarefa',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),),
                ],
              ),
            ),
          )
          : ListView(
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