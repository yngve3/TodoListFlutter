import 'package:flutter/cupertino.dart';
import 'package:untitled/todos/widgets/todo_list_item.dart';
import '../models/todo.dart';

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