
import 'package:flutter/material.dart';
import 'package:primeiro_projeto/data/task_inherited.dart';
import 'package:primeiro_projeto/components/task.dart';

import 'package:primeiro_projeto/Data/task_dao.dart';

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
    TaskDao taskDao = TaskDao();


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
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
            builder: (context, snapshot) {
              List<Task>? items = snapshot.data;
              switch(snapshot.connectionState) {
                case ConnectionState.none || ConnectionState.waiting || ConnectionState.active:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  if (items!.isNotEmpty && snapshot.hasData) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final Task task = items[index];
                        return task;
                      }
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.error, size: 100, color: Colors.redAccent,),
                          Text('Erro ao carregar as tarefas, tente novamente mais tarde',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment_late, size: 100, color: Colors.redAccent,),
                          Text('Nenhuma tarefa cadastrada, clique no botão flutuante para cadastrar uma nova tarefa',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );

              }
            },
            future: taskDao.findAll(),
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