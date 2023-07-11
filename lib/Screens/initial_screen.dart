
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
  bool isTaskListEmpty = true;

  @override
  Widget build(BuildContext context) {
    final taskInherited = TaskInherited.of(context);
    List<Task>? taskList = [];
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
                IconButton(onPressed: () async {
                  taskList = await taskDao.findAll();
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
                case ConnectionState.none:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  if (snapshot.hasData && items!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final Task task = items[index];
                        return task;
                      }
                    );
                  }
                  if (snapshot.hasError) {
                    return const ErrorState();
                  }
                  setState(() {
                    isTaskListEmpty = false;
                    taskList = items;
                  });
                  return const EmptyState();

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