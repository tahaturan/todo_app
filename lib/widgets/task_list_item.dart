import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/local_storage.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/task_model.dart';

// ignore: must_be_immutable
class TaskItem extends StatefulWidget {
  Task task;
  TaskItem({required this.task, Key? key}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final TextEditingController _taskNameController = TextEditingController();
  late LocalStorage _localStorage;

  @override
  void initState() {
    super.initState();
    _localStorage = locator<LocalStorage>();
    _taskNameController.text = widget.task.name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.9),
            blurRadius: 10,
          ),
          BoxShadow(color: Colors.amber.withOpacity(0.5), blurRadius: 8)
        ],
      ),
      child: ListTile(
        title: widget.task.isCompleted
            ? Text(
                widget.task.name,
                style: const TextStyle(
                    decoration: TextDecoration.lineThrough, color: Colors.grey),
              )
            : TextField(
                controller: _taskNameController,
                minLines: 1,
                maxLines: null,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onSubmitted: (newValue) {
                  if (newValue.length > 3) {
                    widget.task.name = newValue;
                    _localStorage.updateTask(task: widget.task);
                  }
                },
              ),
        leading: GestureDetector(
          onTap: () {
            widget.task.isCompleted = !widget.task.isCompleted;
            _localStorage.updateTask(task: widget.task);
            setState(() {});
          },
          child: CircleAvatar(
            backgroundColor:
                widget.task.isCompleted ? Colors.green : Colors.red,
            child: widget.task.isCompleted
                ? const Icon(Icons.check_box_outlined)
                : const Icon(Icons.cancel_outlined),
          ),
        ),
        trailing: Text(
          DateFormat('hh:mm a').format(widget.task.createdAt),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
