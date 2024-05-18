import 'package:flutter/material.dart';
import 'package:maids_test/features/todos/domain/entities/todo_entity.dart';

class TodoListItem extends StatefulWidget {
  final Todo todo;
  final ValueChanged<Todo> onTodoUpdated;
  final ValueChanged<Todo> onTodoDeleted; // Changed to ValueChanged<int>

  const TodoListItem({
    super.key,
    required this.todo,
    required this.onTodoUpdated,
    required this.onTodoDeleted,
  });

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.todo.completed;
  }

  void _toggleCompleted(bool? value) {
    setState(() {
      isCompleted = value!;
      widget.onTodoUpdated(
        Todo(
          id: widget.todo.id,
          todo: widget.todo.todo,
          completed: isCompleted,
          userId: widget.todo.userId, isLocal: widget.todo.isLocal,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.todo.todo),
      subtitle: Text('User ID: ${widget.todo.userId}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => widget.onTodoDeleted(widget.todo), // Fix callback
          ),
          Checkbox(
            value: widget.todo.completed,
            onChanged: _toggleCompleted,
          ),
        ],
      ),
    );
  }
}
