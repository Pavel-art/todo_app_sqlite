import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';
import '../repository/model.dart';
import '../utils/alert_dialog_action_enum.dart';
import 'alertdialog.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;

  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool? _isChecked;

  // _completeUpdate(TodoCubit cubit, Todo todo) {
  //   int id = widget.todo.id;
  //   String title = widget.todo.title;
  //   bool completed = widget.todo.completed;

  //   if (!_isChecked! && !completed) {
  //       cubit.updateTodo(Todo(id: id, title: title, completed: completed = true));
  //       _isChecked = completed;

  //   } else if (_isChecked! && completed) {
  //       cubit.updateTodo(Todo(id: id, title: title, completed: completed = false));
  //       _isChecked = completed;

  //   }else {
  //     _isChecked = !_isChecked!;
  //   }

  // }

  void insertInitState() {
    _isChecked = widget.todo.completed;
  }

  @override
  initState() {
    super.initState();
    insertInitState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TodoCubit>();

    return ListTile(
      onLongPress: () => showDialog<String>(
          context: context,
          builder: (context) => TodoAlertDialog(
                action: ActionDialog.updateTodoAlertDialog,
                todo: widget.todo,
              )),
      title: Text(
        widget.todo.title.toString(),
        style: TextStyle(
            decoration: _isChecked == true
                ? TextDecoration.lineThrough
                : TextDecoration.none),
      ),
      trailing: IconButton(
        color: Colors.red,
        icon: const Icon(Icons.delete),
        onPressed: () => cubit.removeTodo(widget.todo),
      ),
      leading: Checkbox(
        onChanged: (bool? value) {
          setState(() {
            // _completeUpdate(cubit, widget.todo);
            cubit.updateTodo(
              Todo(
                  id: widget.todo.id,
                  title: widget.todo.title,
                  completed: widget.todo.completed = value!),
            );
            _isChecked = value;
          });
        },
        value: _isChecked,
      ),
    );
  }
}
