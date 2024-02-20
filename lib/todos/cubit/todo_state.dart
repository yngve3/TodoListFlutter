import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/todo.dart';

part 'todo_state.freezed.dart';

@freezed
class TodoState with _$TodoState {
  factory TodoState ({
    required List<Todo> todos
  }) = _TodoState;
}
