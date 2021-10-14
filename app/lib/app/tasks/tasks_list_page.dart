import 'package:appwrite_demo/app/tasks/providers/task_list_providers.dart';
import 'package:appwrite_demo/app/tasks/tasks_list_state.dart';
import 'package:appwrite_demo/app/tasks/widget/task_tile.dart';
import 'package:appwrite_demo/models/classes/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskListPage extends ConsumerStatefulWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TaskListPageState();
  }
}

class _TaskListPageState extends ConsumerState<TaskListPage> {
  @override
  void initState() {
    super.initState();

    ref.read(tasksListProvider.notifier).getTasks();
  }

  //
  // ########## Events
  //

  void _toggleTaskCheckbox(String taskId, bool selected) {
    ref.read(tasksListProvider.notifier).toggleTask(taskId, selected);
  }

  //
  // ########## UI
  //

  Widget _buildTaskTile(Task task) {
    return TaskTile(
        task: task,
        onToggled: (bool selected) => _toggleTaskCheckbox(task.id, selected));
  }

  Widget _buildTasksList(TaskListState state) {
    return ListView.builder(
        itemCount: state.tasks.length + ((state.isLoading) ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.tasks.length) {
            return const CircularProgressIndicator();
          }
          return _buildTaskTile(state.tasks[index]);
        });
  }

  Widget _buildEmptyList(TaskListState state) {
    return Center(
      child: Column(
        children: [
          const Text("such empty..."),
          if (state.isLoading) const CircularProgressIndicator()
        ],
      ),
    );
  }

  Widget _buildBody(TaskListState state) {
    if (state.tasks.isEmpty) return _buildEmptyList(state);
    return _buildTasksList(state);
  }

  @override
  Widget build(BuildContext context) {
    final TaskListState state = ref.watch(tasksListProvider);
    return Scaffold(
      body: _buildBody(state),
      appBar: AppBar(
        title: Column(
          children: const [
            Text("Riverpod + StateNotifier + AppWrite"),
            Text("Tasks List"),
          ],
        ),
      ),
    );
  }
}
