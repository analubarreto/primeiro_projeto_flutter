import 'package:primeiro_projeto/components/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:primeiro_projeto/Data/database.dart';

class TaskDao {
  static const String sqlTable = 'CREATE TABLE $_tableName('
        'id INTEGER PRIMARY KEY, '
        '$_name TEXT, '
        '$_photo TEXT,'
        '$_difficulty INTEGER, '
        '$_level INTEGER)';

  static const String _id = 'id';
  static const String _tableName = 'tasks';
  static const String _name = 'name';
  static const String _photo = 'photo';
  static const String _difficulty = 'difficulty';
  static const String _level = 'level';

  save(Task task) async {
    final Database db = await getDataBase();

    bool taskExists = await find(task.id).then((value) => value.isNotEmpty);
    print(taskExists);
    if (taskExists) {
      print(task.id);
      db.update(
        _tableName,
        _toMap(task),
        where: '$_id = ?',
        whereArgs: [task.id],
      );
      return;
    }

    Map<String, dynamic> taskMap = _toMap(task);

    db.insert(_tableName, taskMap);
  }

  updateLevel(int id, int? level) async {
    final Database db = await getDataBase();

    db.rawUpdate(
      'UPDATE $_tableName SET $_level = ? WHERE $_id = ?',
      [level, id],);

    print(level);
  }

  Future<List<Task>> findAll() async {
    final Database db = await getDataBase();

    final List<Map<String, dynamic>> tasksMap = await db.query(_tableName);

    final List<Task> tasks = _toList(tasksMap);

    return tasks;
  }

  Future<List<Task>> find(int? taskId) async {
    final Database db = await getDataBase();

    final List<Map<String, dynamic>> tasksMap = await db.query(
      _tableName,
      where: '$_id = ?',
      whereArgs: [taskId],
    );

    return _toList(tasksMap);
  }

  delete(int? taskId) async {
    final Database db = await getDataBase();

    db.delete(
      _tableName,
      where: '$_id = ?',
      whereArgs: [taskId],
    );
  }


  List<Task> _toList(List<Map<String, dynamic>> taskMap) {
    final List<Task> tasks = [];

    for (Map<String, dynamic> row in taskMap) {
      final Task task = Task(
        id: row[_id],
        name: row[_name],
        photo: row[_photo],
        difficulty: row[_difficulty],
        level: row[_level] ?? row[_level],
      );

      tasks.add(task);
    }

    return tasks;
  }

  Map<String, dynamic> _toMap(Task task) {
    final Map<String, dynamic> taskMap = {};

    taskMap[_name] = task.name;
    taskMap[_photo] = task.photo;
    taskMap[_difficulty] = task.difficulty;
    taskMap[_level] = task.level;

    return taskMap;
  }
}