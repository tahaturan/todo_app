import 'package:todo_app/models/task_model.dart';

abstract class LocalStorage {
  Future<void> addTask({required Task task});
  Future<Task> getTask({required String id});
  Future<List<Task>> getAllTask();
  Future<bool> deleteTask({required Task task});
  Future<Task> updateTask({required Task task});
}

class HiveLocalStorage extends LocalStorage {
  @override
  Future<void> addTask({required Task task}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteTask({required Task task}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAllTask() {
    throw UnimplementedError();
  }

  @override
  Future<Task> getTask({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<Task> updateTask({required Task task}) {
    throw UnimplementedError();
  }
}
