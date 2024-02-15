import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Todo {
  Todo({required this.name});

  final String name;
  bool isCompleted = false;
}

typedef TodoCompleteCallback = Function(Todo todo);
typedef TodoCreateCallback = Function(String name);
typedef TodoDeleteCallback = Function(Todo todo);

class TodoListItem extends StatefulWidget {
  const TodoListItem(
      {super.key,
      required this.todo,
      required this.onTodoComplete,
      required this.onTodoDelete});

  final Todo todo;
  final TodoCompleteCallback onTodoComplete;
  final TodoDeleteCallback onTodoDelete;

  TextStyle? _getTextStyle(BuildContext context) {
    if (!todo.isCompleted) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  State<StatefulWidget> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        widget.todo.name,
        style: widget._getTextStyle(context),
      ),
      onChanged: (newValue) {
        widget.onTodoComplete(widget.todo);
      },
      value: widget.todo.isCompleted,
      controlAffinity: ListTileControlAffinity.leading,
      secondary: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          widget.onTodoDelete(widget.todo);
        },
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList(
      {super.key,
      required this.todos,
      required this.onTodoComplete,
      required this.onTodoDelete});

  final List<Todo> todos;
  final TodoCompleteCallback onTodoComplete;
  final TodoDeleteCallback onTodoDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      verticalDirection: VerticalDirection.up,
      children: todos.map((todo) {
        return TodoListItem(
            todo: todo,
            onTodoComplete: onTodoComplete,
            onTodoDelete: onTodoDelete);
      }).toList(),
    );
  }
}

class TodoCreate extends StatefulWidget {
  const TodoCreate({super.key, required this.onTodoCreate});

  final TodoCreateCallback onTodoCreate;

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
        widget.onTodoCreate(value);
        _controller.clear();
      },
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<StatefulWidget> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final List<Todo> todos = [];

  void _handleTodoCompleted(Todo todo) {
    setState(() {
      todo.isCompleted = !todo.isCompleted;
    });
  }

  void _handleTodoCreate(String name) {
    setState(() {
      todos.add(Todo(name: name));
    });
  }

  void _handleTodoDelete(Todo todo) {
    setState(() {
      todos.remove(todo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Todo list"),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                TodoCreate(onTodoCreate: _handleTodoCreate),
                TodoList(
                  todos: todos.where((todo) => !todo.isCompleted).toList(),
                  onTodoComplete: _handleTodoCompleted,
                  onTodoDelete: _handleTodoDelete,
                ),
                const Divider(),
                TodoList(
                  todos: todos.where((todo) => todo.isCompleted).toList(),
                  onTodoComplete: _handleTodoCompleted,
                  onTodoDelete: _handleTodoDelete,
                )
              ],
            )
        )
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Todo list',
    home: TodoApp(),
  ));
}
