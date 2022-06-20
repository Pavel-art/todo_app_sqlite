import 'data_source.dart';
import 'model.dart';

class TodoRepository {
  final DBProvider todoprovider = DBProvider.db;
 

  Future<List<Todo>> getAlltodos() => todoprovider.getTodos();
  Future<Todo> insertTodo (Todo todo) => todoprovider.insertTodo(todo);
  Future<int> updateTodo (Todo todo) => todoprovider.updateTodo(todo);
  Future<int>deletTodo (Todo todo) => todoprovider.deleteTodo(todo);
}


