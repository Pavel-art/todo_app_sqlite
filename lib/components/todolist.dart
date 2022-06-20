import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sqlite/components/todoitem.dart';

import '../cubit/todo_cubit.dart';
import '../repository/model.dart';



class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(builder: (context, state) {
      // ПОЛУЧАМ ДАННЫЕ ИЗ СТЕЙТА БЛОКА ЧЕРЕЗ BlocBuilder

      if (state is LoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is LoadedState) {
        return ListView.builder(
          itemCount: state.todolist.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(7),
              shadowColor: const Color.fromRGBO(25, 26, 28, 100),
              child: TodoItem(
                todo: Todo(
                  title: (state.todolist as List<Todo>)[index].title,
                  id: (state.todolist as List<Todo>)[index].id,
                  completed: false
                ),
              ),
            );
          },
        );
      }

      if (state is ErrorState) {
        return const Center(
          child: Text("ERROR"),
        );
      } else {
        return const Center(
          child: Text("Список пуст !"),
        );
      }
    });
  }
}
