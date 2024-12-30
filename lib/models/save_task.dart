import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'task_model.dart';

class SaveTask extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  SaveTask() {
    _loadTasks(); // Load tasks when the model is initialized.
  }

  void addTask(Task task) {
    if (task.title.trim().isEmpty) {
      throw ArgumentError('Task title cannot be empty.');
    }
    _tasks.add(task);
    _saveTasks();
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    _saveTasks();
    notifyListeners();
  }

  void checkTask(int index) {
    _tasks[index].isDone();
    _saveTasks();
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = _tasks.map((task) => task.toJson()).toList();
    prefs.setString('tasks', jsonEncode(taskList));
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? taskData = prefs.getString('tasks');
    if (taskData != null) {
      final List<dynamic> taskList = jsonDecode(taskData);
      _tasks = taskList.map((task) => Task.fromJson(task)).toList();
      notifyListeners();
    }
  }
}
