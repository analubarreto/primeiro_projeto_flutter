import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child) {
    calculateTotalLevel();
  }

  final List<Task> taskList = [
    Task('Aprender Flutter', 'assets/images/dash.png', 3, 0),
    Task('Andar de Bike', 'assets/images/bike.webp', 2, 0),
    Task('Meditar', 'assets/images/meditar.jpeg', 5, 0),
    Task('Ler', 'assets/images/livro.jpg', 4, 0),
    Task('Jogar', 'assets/images/jogar.jpg', 1, 0),
  ];

  late double totalLevel = 0;

  void newTask(String name, String photo, int difficulty) {
    Task newTask = Task(name, photo, difficulty, 0);
    taskList.add(newTask);
  }

  void updateLevel(int level) {
    for (var element in taskList) {
      if (element.level > element.difficulty * 10) element.level = element.difficulty * 10;
    }}

  void calculateTotalLevel() {
    double listLevel = taskList.fold(0, (previousValue, element) => previousValue + element.level);
    double totalDifficulty = taskList.fold(0, (previousValue, element) => previousValue + element.difficulty);
    totalLevel = (listLevel / (totalDifficulty * 10)) * 100;
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList != taskList || oldWidget.totalLevel != totalLevel;
  }
}
