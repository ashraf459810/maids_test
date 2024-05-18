import 'package:flutter/material.dart';

class AddTodoDialog extends StatefulWidget {
  final Function(String, bool) onAdd;

  const AddTodoDialog({required this.onAdd, super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final TextEditingController _newTodoController = TextEditingController();
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Add New Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _newTodoController,
            decoration: const InputDecoration(
              hintText: 'Enter todo text',
            ),
          ),
          Row(
            children: [
              const Text('Completed'),
              Checkbox(
                value: _isCompleted,
                onChanged: (bool? value) {
                  setState(() {
                    _isCompleted = value!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_newTodoController.text.isNotEmpty) {
              widget.onAdd(_newTodoController.text, _isCompleted);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
