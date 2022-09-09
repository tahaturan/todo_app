import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/local_storage.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/widgets/task_list_item.dart';

import '../models/task_model.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Task> allTasks;

  CustomSearchDelegate({required this.allTasks});

  @override
  List<Widget>? buildActions(BuildContext context) {
    //* aramakisminin sag tafindaki iconlari

    return [
      IconButton(
        onPressed: () {
          query.isEmpty ? null : query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //* en bastaki iconlari

    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 24),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //* Bir arama yapip arama butonuna bastigimizda cikacak olan sonuclari nasil gostermek istedigimizi

    List<Task> filteredList = allTasks
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return filteredList.isNotEmpty
        ? ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (BuildContext context, int index) {
              var task = filteredList[index];
              return Dismissible(
                key: Key(task.id),
                onDismissed: (direction) async {
                  filteredList.removeAt(index);
                  await locator<LocalStorage>().deleteTask(task: task);
                },
                background: Card(
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.delete_forever, color: Colors.white),
                      const SizedBox(width: 5),
                      Text(
                        'remove_task'.tr(),
                        // ignore: prefer_const_constructors
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
        : Center(
            // ignore: prefer_const_constructors
            child: Text('search_not_found').tr(),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //* kullanici bir veya iki harf yazdiginda yada hic birsey yazmadiginda gostermek istedigimiz veriler
    return Container();
  }
}
