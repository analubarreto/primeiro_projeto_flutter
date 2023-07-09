import 'package:primeiro_projeto/components/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:primeiro_projeto/Data/database.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

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
    if (taskExists) {
      db.update(
        _tableName,
        _toMap(task),
        where: '$_id = ?',
        whereArgs: [task.id],
      );
      return;
    }

    var taskId = Uuid().v4(options: {'rng': UuidUtil.cryptoRNG});
    task.id = taskId;

    Map<String, dynamic> taskMap = _toMap(task);

    db.insert(_tableName, taskMap);
  }

  Future<List<Task>> findAll() async {
    final Database db = await getDataBase();

    final List<Map<String, dynamic>> tasksMap = await db.query(_tableName);

    final List<Task> tasks = _toList(tasksMap);

    return tasks;
  }

  Future<List<Task>> find(String taskId) async {
    final Database db = await getDataBase();

    final List<Map<String, dynamic>> tasksMap = await db.query(
      _tableName,
      where: '$_name = ?',
      whereArgs: [taskId],
    );

    return _toList(tasksMap);
  }

  delete(String taskId) async {
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
        row[_id],
        row[_name],
        row[_photo],
        row[_difficulty],
        row[_level],
      );
      tasks.add(task);
    }

    return tasks;
  }

  Map<String, dynamic> _toMap(Task task) {
    final Map<String, dynamic> taskMap = {};

    taskMap[_name] = task.name;
    taskMap[_difficulty] = task.difficulty;
    taskMap[_level] = task.level;

    return taskMap;
  }
}