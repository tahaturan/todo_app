import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_app/data/local_storage.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widgets/task_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> allTask;

  late LocalStorage _localStorage;

  @override
  void initState() {
    super.initState();
    _localStorage = locator<LocalStorage>();
    allTask = <Task>[];
    _getAllTaskFrom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('AnaSayfa'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              _showAddTaskBottomSheet(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: allTask.isNotEmpty
          ? ListView.builder(
              itemCount: allTask.length,
              itemBuilder: (BuildContext context, int index) {
                var task = allTask[index];
                return Dismissible(
                  key: Key(task.id),
                  onDismissed: (direction) {
                    allTask.removeAt(index);
                    _localStorage.deleteTask(task: task);
                    setState(() {});
                  },
                  background: Card(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.delete_forever, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          "Gorev Siliniyor...",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    color: index % 2 == 0
                        ? Colors.blue.shade200
                        : Colors.amber.shade200,
                    child: TaskItem(task: task),
                  ),
                );
              },
            )
          : const Center(
              child: Text("Henuz bir gorev eklemediniz..."),
            ),
    );
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ListTile(
            title: TextField(
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
                hintText: "Gorev",
                border: InputBorder.none,
                icon: Icon(Icons.edit),
              ),
              onSubmitted: (value) {
                Navigator.pop(context);
                if (value.length > 3) {
                  DatePicker.showTimePicker(
                    context,
                    showSecondsColumn: false,
                    onConfirm: (time) async {
                      var yeniEklenecekGorev =
                          Task.create(name: value, createdAt: time);
                      allTask.add(yeniEklenecekGorev);
                      await _localStorage.addTask(task: yeniEklenecekGorev);
                      setState(() {});
                    },
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _getAllTaskFrom() async {
    allTask = await _localStorage.getAllTask();
    setState(() {});
  }
}
