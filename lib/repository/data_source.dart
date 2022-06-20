import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'model.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static late Database _database;

  String tableTodo = 'Todos';
  String columnId = 'id';
  String columnTitle = 'title';
  String columnDone = 'completed';

  Future<Database> get database async {
    //if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}Todo.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute('''
create table $tableTodo ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnDone integer not null)
''');
  }

  // READ
  Future<List<Todo>> getTodos() async {
    Database db = await database;
    final List<Map<String, dynamic>> todosMapList = await db.query(tableTodo);
    final List<Todo> todolist = [];
    for (var todoMap in todosMapList) {
      todolist.add(Todo.fromMap(todoMap));
    }

    return todolist;
  }

  // INSERT
  Future<Todo> insertTodo(Todo todo) async {
    Database db = await database;
  await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  // UPDATE
  Future<int> updateTodo(Todo todo) async {
    Database db = await database;
    return await db.update(
      tableTodo,
      todo.toMap(),
      where: '$columnId = ?',
      whereArgs: [todo.id],
    );
  }

  // DELETE
  Future<int> deleteTodo(Todo todo) async {
    Database db = await database;
    return await db.delete(
      tableTodo,
      where: '$columnId = ?',
      whereArgs: [todo.id],
    );
  }

  Future close() async => db.close();
}
