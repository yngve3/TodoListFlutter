import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/todo_cubit.dart';
import '../models/todo.dart';

class TodoCreate extends StatefulWidget {
  const TodoCreate({super.key});

  @override
  State<StatefulWidget> createState() => _TodoCreateState();
}

class _TodoCreateState extends State<TodoCreate> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onSubmitted: (String value) {
        context.read<TodoCubit>().createTodo(Todo(text: value));
        _controller.clear();
      },
    );
  }
}