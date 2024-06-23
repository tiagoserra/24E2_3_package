import 'dart:convert';

import 'package:management_task_package/models/task_model.dart';
import 'package:management_task_package/providers/firebase_provider.dart';

class TaskService {
  static const String url = "https://flutter-tasks-27c22-default-rtdb.firebaseio.com/";
  static const String resource = "tasks";

  static Future<Task> insert(Task task) async {
    String res = await FirebaseProvider.httpPost(url, resource, jsonEncode(task.toJson()));

    task.id = res;

    return task;
  }

  static Future<Task> update(Task task) async {
    
    await FirebaseProvider.httpPut(url, "$resource/${task.id}", jsonEncode(task.toJson()));

    return task;
  }

  static Future<bool> delete(Task task) async {

    await FirebaseProvider.httpDelete(url, "$resource/${task.id}");

    return true;
  }

  static Future<List<Task>> getAll() async {
    String res = await FirebaseProvider.httpGet(url, resource);

    Map<String, dynamic> data = jsonDecode(res);

    List<Task> tasks = [];

    data.forEach((key, value) {
      Task task = Task.fromJson(key, value);
      tasks.add(task);
    });

    return tasks;
  }

  static Future<Task> getById(String id) async {
    String res = await FirebaseProvider.httpGet(url, "$resource/$id.json");

    Map<String, dynamic> data = jsonDecode(res);

    Task task = Task.fromJson(id, data);

    return task;
  }
}
