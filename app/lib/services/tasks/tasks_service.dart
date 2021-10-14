import 'package:appwrite_demo/models/classes/task.dart';
import 'package:appwrite_demo/models/enums/task_priority.dart';

abstract class ITasksService {
  Future<List<Task>> getTasks();
}

class TasksService implements ITasksService {
  @override
  Future<List<Task>> getTasks() {
    return Future.delayed(const Duration(seconds: 2)).then((_) => [
          Task(
              id: "fake_id_1",
              title: "Task 1",
              done: false,
              priority: TaskPriority.normal,
              date: DateTime.utc(2021, 10, 10)),
          Task(
              id: "fake_id_2",
              title: "Task 2",
              done: false,
              priority: TaskPriority.normal,
              date: DateTime.utc(2021, 10, 13)),
        ]);
  }
}
