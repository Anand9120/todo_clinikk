import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_clinikk/models/save_task.dart';
import 'package:todo_clinikk/models/task_model.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key});
  final controller = TextEditingController();

  void showTopSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                // Validation before adding the task
                if (controller.text.trim().isEmpty) {
                  // Show SnackBar at the top if the title is empty
                  showTopSnackBar(context, 'Task title cannot be empty.');
                  return;
                }
                // Add the task if the title is valid
                context.read<SaveTask>().addTask(
                  Task(title: controller.text.trim(), isCompleted: false),
                );
                controller.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
