import 'dart:convert';

import 'package:get/get.dart';
import 'package:to_do_list/app/core/utils/keys.dart';
import 'package:to_do_list/app/data/modules/task.dart';
import 'package:to_do_list/app/data/services/storage/services.dart';

class TaskProvider {
  final StorageService _storage = Get.find<StorageService>();

  List<Task> readTasks() {
    /*
    & reads the local storage using the key that is given to the function
    & for each entry that we get in the json file, we will convert that entry into a task object
    & that task object will be stored in our tasks list
    & we decode the json string into our dart object
    & the list stored under 'tasks' will initially be empty and then we can add multiple tasks

    *format in which our data will be stored
    {'tasks' : [
        {
          title: <title>,
          color: <colorcode>
          icon : <icondata>
        }]
    } 

    */
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    var writeValue = jsonEncode(tasks);
    _storage.write(taskKey, writeValue);
  }
}
