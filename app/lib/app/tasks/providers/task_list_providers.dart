import 'package:appwrite_demo/app/tasks/notifier/task_list_notifier.dart';
import 'package:appwrite_demo/app/tasks/tasks_list_state.dart';
import 'package:appwrite_demo/services/tasks/tasks_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier
final tasksListProvider =
    StateNotifierProvider<TaskListNotifier, TaskListState>(
        (ref) => TaskListNotifier(service: ref.watch(_tasksServiceProvider)));

// Service Provider
final _tasksServiceProvider = Provider<ITasksService>((ref) => TasksService());
