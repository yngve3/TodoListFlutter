import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/todo_cubit.dart';
import '../models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({super.key, required this.todo});

  final Todo todo;

  TextStyle? _getTextStyle(BuildContext context) {
    if (!todo.isCompleted) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        todo.text,
        style: _getTextStyle(context),
      ),
      onChanged: (newValue) {
        context.read<TodoCubit>().changeTodoCompleteness(todo);
      },
      value: todo.isCompleted,
      controlAffinity: ListTileControlAffinity.leading,
      secondary: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          context.read<TodoCubit>().deleteTodo(todo);
        },
      ),
    );
  }
}