import 'data_source.dart';
import 'model.dart';

class TodoRepository {
  final DBProvider todoProvider = DBProvider.db;
 

  Future<List<Todo>> getAllTodos() => todoProvider.getTodos();
  Future<Todo> insertTodo (Todo todo) => todoProvider.insertTodo(todo);
  Future<int> updateTodo (Todo todo) => todoProvider.updateTodo(todo);
  Future<int>deleteTodo (Todo todo) => todoProvider.deleteTodo(todo);
}


