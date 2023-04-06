import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:isar/isar.dart';
import 'package:practice_flutter_isar/main.dart';
import 'package:practice_flutter_isar/schema.dart';

class IsarServices {
  Future<List<Todos>> getAllTodo() {
    return isar.todos.where().build().findAll();
  }

  Future<List<Tasks>> getAllTask() {
    return isar.tasks.where().build().findAll();
  }

  Future<void> addTodo(Tasks task, String titleEdit, String descEdit,
      String timeEdit, Function() set) async {
    Todos todosCreate = Todos(name: titleEdit, description: descEdit)
      ..task.value = task;

    await isar.writeTxn(() async {
      await isar.todos.put(todosCreate);
      await todosCreate.task.save();
    });
  }

  Future<void> addTask(String titleEdit, String descEdit) async {
    final taskCreate = Tasks(
        title: titleEdit, description: descEdit, taskColor: Colors.green.value);

    await isar.writeTxn(() async {
      await isar.tasks.put(taskCreate);
    });
    // EasyLoading.showSuccess('创建分类',
    //     duration: const Duration(milliseconds: 500));
  }
}
