import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/task.dart';
import 'package:primeiro_projeto/Data/task_dao.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child) {
    calculateTotalLevel();
  }

  final List<Task> taskList = [];

  late double totalLevel = 0;

  void updateLevel(int? level) {
    for (var element in taskList) {
      if (element.level! > element.difficulty * 10) element.level = element.difficulty * 10;
    }}

  void calculateTotalLevel() {
    double listLevel = taskList.fold(0, (previousValue, element) => previousValue + element.level!);
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
