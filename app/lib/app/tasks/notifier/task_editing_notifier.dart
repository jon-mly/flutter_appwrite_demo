import 'package:appwrite_demo/app/tasks/data/task_editing_state.dart';
import 'package:appwrite_demo/models/classes/task.dart';
import 'package:appwrite_demo/models/enums/task_priority.dart';
import 'package:appwrite_demo/services/tasks/tasks_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskEditingNotifier extends StateNotifier<TaskEditingState> {
  TaskEditingNotifier({required ITasksService service, Task? initialTask})
      : _service = service,
        super((initialTask != null)
            ? TaskEditingState.edit(initialTask)
            : TaskEditingState.create());

  final ITasksService _service;

  //
  // User Actions
  //

  void registerSelectedPriority(TaskPriority priority) {}

  void registerSelectedReminderDate(DateTime date) {}

  //
  // Service Actions
  //

  Future<void> saveTask() async {
    state = state.copyWith(status: TaskEditingStatus.loading);

    await Future.delayed(const Duration(seconds: 2)).then((value) {
      state = state.copyWith(status: TaskEditingStatus.success);
    });

    // TODO: if doc exists, edit, else save
  }
}
