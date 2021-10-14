import 'package:appwrite_demo/app/tasks/tasks_list_state.dart';
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
    state = TaskListState(tasks: tasks, isLoading: false);

    // Implement
  }

  Future<void> getTasks() async {
    state = TaskListState(tasks: state.tasks, isLoading: true);

    try {
      await _service.getTasks().then((List<Task> tasks) {
        state = TaskListState(tasks: tasks, isLoading: false);
      });
    } catch (e) {
      state = TaskListState(tasks: state.tasks, isLoading: false);
      // Error handling to set up
    }
  }
}
