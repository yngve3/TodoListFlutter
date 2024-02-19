part of 'todo_bloc.dart';

abstract class TodoEvent {}
final class TodoCreatePressed extends TodoEvent {
  final Todo todo;
  TodoCreatePressed(this.todo);
}
final class TodoDeletePressed extends TodoEvent {
  final Todo todo;
  TodoDeletePressed(this.todo);
}
final class TodoCompletedPressed extends TodoEvent {
  final Todo todo;
  TodoCompletedPressed(this.todo);
}
