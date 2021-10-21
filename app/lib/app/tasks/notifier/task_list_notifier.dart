import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite_demo/app/tasks/data/tasks_list_state.dart';
import 'package:appwrite_demo/models/classes/task.dart';
import 'package:appwrite_demo/services/tasks/tasks_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskListNotifier extends StateNotifier<TaskListState> {
  TaskListNotifier({required ITasksService service, required String? userId})
      : _service = service,
        _userId = userId,
        super(TaskListState.initial()) {
    _getTasksStream();
  }

  final ITasksService _service;
  final String? _userId;

  StreamSubscription<RealtimeMessage>? tasksStreamSubscription;

  @override
  void dispose() {
    tasksStreamSubscription?.cancel();
    super.dispose();
  }

  //
  // Stream
  //

  void _getTasksStream() {
    tasksStreamSubscription =
        _service.getTasksStream().listen(_handleTaskStreamUpdate);
  }

  void _handleTaskStreamUpdate(RealtimeMessage message) {
    print(message);
    // TODO: is there a way to only get documents from the collection created by the user ?
    // This stream listens for [........]
    // For this type of channel, three events are returned :
  }

  //
  // Tasks
  //

  Future<void> toggleTask(String id, bool selected) async {
    // Internal update
    List<Task> tasks = state.tasks;
    tasks = tasks.map((task) {
      if (task.id == id) {
        task.done = selected;
        task.doneDate = (selected) ? DateTime.now() : null;
        return task;
      }
      return task;
    }).toList();
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
      rethrow;
      // Error handling to set up
    }
  }
}
