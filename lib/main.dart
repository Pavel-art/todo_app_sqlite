import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sqlite/repository/repository.dart';
import 'package:todo_app_sqlite/utils/alert_dialog_action_enum.dart';

import 'components/alertdialog.dart';
import 'components/todolist.dart';
import 'cubit/todo_cubit.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final repository = TodoRepository();
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoCubit>(
      create: (context) => TodoCubit(repository),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Заметки"),
        centerTitle: true,
      ),
      body: const TodoList(),
      floatingActionButton: myfloatingAvtionButton(context),
    );
  }
}

Widget myfloatingAvtionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () => showDialog<String>(
        context: context, builder: (context) => TodoAlertDialog(action: ActionDialog.addTodoAlertDialog,)),
    child: const Icon(Icons.add),
  );
}
