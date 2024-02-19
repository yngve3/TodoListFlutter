import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/todo_bloc.dart';

import 'Todo.dart';

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
        context.read<TodoBloc>().add(TodoCompletedPressed(todo));
      },
      value: todo.isCompleted,
      controlAffinity: ListTileControlAffinity.leading,
      secondary: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          context.read<TodoBloc>().add(TodoDeletePressed(todo));
        },
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Column(
      verticalDirection: VerticalDirection.up,
      children: todos.map((todo) {
        return TodoListItem(todo: todo);
      }).toList(),
    );
  }
}

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
        context.read<TodoBloc>().add(TodoCreatePressed(Todo(value)));
        _controller.clear();
      },
    );
  }
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Todo list"),
        ),
        body: BlocBuilder<TodoBloc, TodoState> (
            builder: (context, state) {
              return SingleChildScrollView(
                  child: Column(
                    children: [
                      const TodoCreate(),
                      TodoList(
                        todos: state.todos.where((todo) => !todo.isCompleted).toList(),
                      ),
                      const Divider(),
                      TodoList(
                        todos: state.todos.where((todo) => todo.isCompleted).toList(),
                      )
                    ],
                  )
              );
            }
        )
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Todo list',
    home: BlocProvider(
      create: (_) => TodoBloc(),
      child: const TodoApp(),
    ),
  ));
}
