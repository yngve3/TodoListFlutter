import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'Todo.freezed.dart';

@unfreezed
class Todo with _$Todo {
  factory Todo({
    required final String text,
    @Default(false) bool isCompleted
  }) = _Todo;
}