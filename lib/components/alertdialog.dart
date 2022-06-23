import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';
import '../repository/model.dart';
import '../utils/alert_dialog_action_enum.dart';

class TodoAlertDialog extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final ActionDialog? action;
  final Todo? todo;

  TodoAlertDialog({Key? key, required this.action, this.todo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TodoCubit>();
    return AlertDialog(
      title: action == ActionDialog.updateTodoAlertDialog
          ? const Text('Изменить заметку')
          : const Text('Создать новую заметку'),
      content: TextField(
        decoration: const InputDecoration(isDense: true),
        controller: _controller,
        autofocus: true,
        maxLines: 3,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => {
            if (_controller.text.trim().isEmpty)
              {
                Fluttertoast.showToast(
                    msg: "Поле не может быть пустым!",
                    gravity: ToastGravity.CENTER)
              }
            else
              {
                action == ActionDialog.updateTodoAlertDialog
                    ? cubit.updateTodo(Todo(
                        id: todo!.id,
                        title: _controller.text,
                        completed: todo!.completed))
                    : cubit.addTodo(
                        Todo(
                            title: _controller.text,
                            id: DateTime.now().microsecond.toInt(),
                            completed: false),
                      ),
                Navigator.pop(context, 'OK')
              }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
