import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:primeiro_projeto/Data/task_dao.dart';

Future<Database> getDataBase() async {
  final String path = join(await getDatabasesPath(), 'tasks.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(TaskDao.sqlTable);
    },
    version: 1,
  );
}