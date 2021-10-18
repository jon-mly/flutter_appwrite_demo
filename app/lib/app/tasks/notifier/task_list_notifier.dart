import 'package:appwrite_demo/app/tasks/data/tasks_list_state.dart';
import 'package:appwrite_demo/models/classes/task.dart';
import 'package:appwrite_demo/services/tasks/tasks_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskListNotifier extends StateNotifier<TaskListState> {
  TaskListNotifier({required ITasksService service})
      : _service = service,
        super(TaskListState.initial());

  final ITasksService _service;

  //
  // Tasks
  //

  Future<void> toggleTask(String id, bool selected) async {
    // Internal update
    List<Task> tasks = state.tasks;
    tasks.firstWhere((task) => task.id == id).done = selected;
    state = state.copyWith(tasks: tasks);

    // Implement AppWrite
  }

  Future<void> deleteTask(Task task) async {}

  Future<void> getTasks() async {
    state = state.copyWith(status: TaskListStatus.loading);

    try {
      await _service.getTasks().then((List<Task> tasks) {
        state = state.copyWith(tasks: tasks, status: TaskListStatus.loaded);
      });
    } catch (e) {
      state = state.copyWith(status: TaskListStatus.failed);
      // Error handling to set up
    }
  }
}
