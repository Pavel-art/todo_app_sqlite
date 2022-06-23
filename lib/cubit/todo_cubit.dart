

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/model.dart';
import '../repository/repository.dart';


part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
final TodoRepository repository;
 
   
   TodoCubit(this.repository) : super(EmptyState()) {

     try{
         fetchTodos();
     }catch (_){
         throw ErrorDescription('State error');
     }
           
   }

  Future<void> fetchTodos() async {
    try {
      emit(LoadingState());
      final List<Todo> loadedTodoList = await repository.getAllTodos();
      emit(LoadedState(todolist: loadedTodoList));
    } catch (_) {
      emit(ErrorState());
    }
  }
  Future<void> addTodo(Todo todo) async {
    try {
      repository.insertTodo(todo);
      final List<Todo> loadedTodoList = await repository.getAllTodos();
      emit(LoadedState(todolist: loadedTodoList));
    } catch (_) {
      emit(ErrorState());
    }
  }


Future<void> updateTodo (Todo todo) async {
  try {
      repository.updateTodo(todo);
      final List<Todo> loadedTodoList = await repository.getAllTodos();
      emit(LoadedState(todolist: loadedTodoList));
    } catch (_) {
      emit(ErrorState());
    } 
}


 Future<void> removeTodo(Todo todo) async {
    try {
      repository.deleteTodo(todo);
      final List<Todo> loadedTodoList = await repository.getAllTodos();
      emit(LoadedState(todolist: loadedTodoList));
    } catch (_) {
      emit(ErrorState());
    }
  }

}

