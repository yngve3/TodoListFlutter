import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'todo.freezed.dart';

@freezed
class Todo with _$Todo {
  factory Todo({
    required String text,
    @Default(false) bool isCompleted
  }) = _Todo;
}