import 'package:appwrite_demo/models/classes/task.dart';
import 'package:appwrite_demo/models/enums/task_priority.dart';

abstract class ITasksService {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(Task task);
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

  @override
  Future<void> addTask(Task task) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(Task task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(Task task) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }
}
