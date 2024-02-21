import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/todo_cubit.dart';
import '../cubit/todo_state.dart';
import '../widgets/todo_create.dart';
import '../widgets/todo_list.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list',
      home: BlocProvider(
        create: (_) => TodoCubit(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Todo list"),
            ),
            body: BlocBuilder<TodoCubit, TodoState> (
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
        ),
      ),
    );
  }
}