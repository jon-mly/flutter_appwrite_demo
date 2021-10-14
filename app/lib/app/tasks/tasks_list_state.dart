import 'package:appwrite_demo/models/classes/task.dart';

class TaskListState {
  final List<Task> tasks;
  final bool isLoading;

  TaskListState({required this.tasks, required this.isLoading});

  factory TaskListState.initial() => TaskListState(tasks: [], isLoading: false);
}
