import 'package:flutter_bloc/flutter_bloc.dart';
import '../Todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState([])) {
    on<TodoCreatePressed>((event, emit) {
      List<Todo> currentList = state.todos;
      currentList.add(event.todo);
      emit(TodoState(currentList));
    });
    on<TodoCompletedPressed>((event, emit) {
      event.todo.isCompleted = !event.todo.isCompleted;
      emit(TodoState(state.todos));
    });
    on<TodoDeletePressed>((event, emit) {
      List<Todo> currentList = state.todos;
      currentList.remove(event.todo);
      emit(TodoState(currentList));
    });
  }
}
