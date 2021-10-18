import 'package:appwrite_demo/app/tasks/data/task_editing_state.dart';
import 'package:appwrite_demo/app/tasks/notifier/task_editing_notifier.dart';
import 'package:appwrite_demo/app/tasks/providers/task_list_providers.dart';
import 'package:appwrite_demo/models/classes/task.dart';
import 'package:appwrite_demo/models/enums/task_priority.dart';
import 'package:appwrite_demo/models/ui_data/task_priority_ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskEditBottomSheet extends ConsumerStatefulWidget {
  final Task? editedTask;

  const TaskEditBottomSheet({Key? key, this.editedTask}) : super(key: key);

  @override
  _TaskEditBottomSheetState createState() => _TaskEditBottomSheetState();
}

class _TaskEditBottomSheetState extends ConsumerState<TaskEditBottomSheet> {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();

  bool _priorityAccordionOpen = false;

  AutoDisposeStateNotifierProvider<TaskEditingNotifier, TaskEditingState>
      get provider => taskEditingProviderFamily(widget.editedTask);

  //
  // ######### Lifecycle
  //

  @override
  void initState() {
    super.initState();

    final Task? initialTask = ref.read(provider).task;

    if (initialTask != null) {
      _titleEditingController.text = initialTask.text ?? "";
      _titleEditingController.text = initialTask.title ?? "";
    }
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  //
  // ######### UI Events
  //

  void _togglePriorityAccordion() {
    setState(() {
      _priorityAccordionOpen = !_priorityAccordionOpen;
    });
  }

  void _presentReminderDateSelection() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));
    if (picked == null) return;
    _setSelectedReminderDate(picked);
  }

  //
  // ######### Events
  //

  void _selectPriority(TaskPriority priority) {
    ref.read(provider.notifier).registerSelectedPriority(priority);
  }

  void _setSelectedReminderDate(DateTime date) {
    ref.read(provider.notifier).registerSelectedReminderDate(date);
  }

  Future<void> _saveTask() async {
    await ref.read(provider.notifier).saveTask();

    TaskEditingStatus status = ref.read(provider).status;
    if (status == TaskEditingStatus.success) {
      Navigator.of(context).pop();
    }
  }

  //
  // ######### UI
  //

  Widget _buildTitleField() {
    return TextField(
      controller: _titleEditingController,
      decoration: const InputDecoration(hintText: "Title"),
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: _textEditingController,
      decoration: const InputDecoration(hintText: "Add a description"),
    );
  }

  Widget _buildPrioritySelector() {
    const TaskPriority priority = TaskPriority.normal;
    final TaskPriorityUiElements priorityUiElements =
        TaskPriorityUiElements.priority(priority);
    return Column(
      children: [
        InkWell(
            onTap: _togglePriorityAccordion,
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: priorityUiElements.color),
                ),
                const Padding(padding: EdgeInsets.only(left: 12)),
                Text(priorityUiElements.title)
              ],
            )),
        (_priorityAccordionOpen)
            ? _buildPrioritySelectorAccordion()
            : Container(),
      ],
    );
  }

  Widget _buildPrioritySelectorAccordion() {
    return Column(
      children: TaskPriority.values.map((priority) {
        final TaskPriorityUiElements priorityUiElements =
            TaskPriorityUiElements.priority(priority);
        return InkWell(
          onTap: () => _selectPriority(priority),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: priorityUiElements.color),
              ),
              const Padding(padding: EdgeInsets.only(left: 12)),
              Text(priorityUiElements.title)
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildReminderDate() {
    bool isDateSelected = false;
    return InkWell(
      onTap: _presentReminderDateSelection,
      child: (isDateSelected)
          ? Text(DateTime.now().toString())
          : const Text("Add a reminder date"),
    );
  }

  Widget _buildSaveButton() {
    final status =
        ref.watch(provider.select((TaskEditingState state) => state.status));
    return ElevatedButton(
      onPressed: _saveTask,
      child: (status == TaskEditingStatus.loading)
          ? const CircularProgressIndicator()
          : const Text("Save"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> sheetWidgetList = [
      _buildTitleField(),
      _buildTextField(),
      _buildPrioritySelector(),
      _buildReminderDate(),
      _buildSaveButton(),
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.separated(
        itemCount: sheetWidgetList.length,
        itemBuilder: (_, index) => sheetWidgetList[index],
        separatorBuilder: (_, __) =>
            const Padding(padding: EdgeInsets.only(bottom: 20)),
      ),
    );
  }
}