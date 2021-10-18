import 'package:appwrite_demo/models/classes/task.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'task_editing_state.g.dart';

@CopyWith()
class TaskEditingState {
  Task task;
  TaskEditingStatus status;

  TaskEditingState(
      {required this.task, this.status = TaskEditingStatus.initial});

  factory TaskEditingState.edit(Task task) => TaskEditingState(task: task);
  factory TaskEditingState.create() => TaskEditingState(task: Task.empty());
}

enum TaskEditingStatus { initial, loading, success }
