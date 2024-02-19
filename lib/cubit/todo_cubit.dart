import 'package:flutter_bloc/flutter_bloc.dart';
import '../Todo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoState([]));

  void createTodo(Todo todo) {
    List<Todo> currentList = state.todos;
    currentList.add(todo);
    emit(TodoState(currentList));
  }

  void deleteTodo(Todo todo) {
    List<Todo> currentList = state.todos;
    currentList.remove(todo);
    emit(TodoState(currentList));
  }

  void changeTodoCompleteness(Todo todo) {
    todo.isCompleted = !todo.isCompleted;
    emit(TodoState(state.todos));
  }
}
