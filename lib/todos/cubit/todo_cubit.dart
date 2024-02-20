import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/todos/cubit/todo_state.dart';
import '../models/todo.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoState(todos: []));

  void createTodo(Todo todo) {
    emit(TodoState(
        todos: List.of(state.todos)..add(todo))
    );
  }

  void deleteTodo(Todo todo) {
    emit(TodoState(
        todos: List.of(state.todos)..remove(todo))
    );
  }

  void changeTodoCompleteness(Todo todo) {
    final Todo changedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
    List<Todo> list = List.of(state.todos);
    list[list.indexOf(todo)] = changedTodo;
    emit(TodoState(todos: list));
  }
}
