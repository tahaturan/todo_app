import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_app/models/task_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
      body: Container(),
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
                    onConfirm: (time) {
                      var yeniEklenecekGorev =
                          Task.create(name: value, createdAt: time);
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
}
