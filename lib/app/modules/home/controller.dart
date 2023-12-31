import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/data/modules/task.dart';
import 'package:to_do_list/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  // keeping track of the tasks that we are doing/done that are being done
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;
  // keeps track of the task in that we click in our dialog box
  final task = Rx<Task?>(null);
  //.obs is the method of a reactive list that will  observe the changes made to this list
  final tasks = <Task>[].obs;
  //keeps track of the tab number in the app's bottom navigation
  final tabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // all the values in the list will be assigned based on the itemns present in the repo
    tasks.assignAll(taskRepository.readTasks());
    // whenever the tasks change, we are also gonna change the vlaue on the repp
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    //* disposal is also done here
    editController.dispose();
    super.onClose();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  // void changeTheme(state) {
  //   if (state == true) {
  //     isDark = true;
  //     Get.changeTheme(ThemeData.dark());
  //   } else {
  //     isDark = false;
  //     Get.changeTheme(ThemeData.light());
  //   }
  //   update();
  // }

  bool addTask(Task t) {
    if (tasks.contains(t)) {
      // only because of the equatable extension on task, we are able to do this step
      return false;
    }
    tasks.add(t);
    return true;
  }

  void deleteTask(Task t) {
    tasks.remove(t);
  }

  void changeTask(Task? selectedTask) {
    task.value = selectedTask;
  }

  updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containsTodo(todos, title)) {
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }

  void changeTodos(List<dynamic> selected) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < selected.length; i++) {
      var todo = selected[i];
      var status = todo['done'];
      if (status == true) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
    doneTodos.refresh();
    doingTodos.refresh();
  }

  bool containsTodo(List todos, String title) {
    return todos.any((element) => element['title'] == title);
  }

  bool addTodo(String title) {
    var todo = <String, dynamic>{'title': title, 'done': false};
    if (doingTodos
        .any((element) => mapEquals<String, dynamic>(todo, element))) {
      return false;
    }
    var doneTodo = <String, dynamic>{
      'title': title,
      'done': true,
    };
    if (doneTodos.any((element) => mapEquals(doneTodo, element))) {
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([...doingTodos, ...doneTodos]);
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIndex = tasks.indexOf(task.value);
    tasks[oldIndex] = newTask;
    tasks.refresh();
  }

  void markTodoAsDone(String title) {
    var currentTodo = <String, dynamic>{'title': title, 'done': false};
    int index = doingTodos.indexWhere(
        (element) => mapEquals<String, dynamic>(currentTodo, element));
    doingTodos.removeAt(index);
    var doneCurrentTodo = <String, dynamic>{'title': title, 'done': true};
    doneTodos.add(doneCurrentTodo);
    doingTodos.refresh();
    doneTodos.refresh();
  }

  void deleteDoneTodo(dynamic doneTodo) {
    int index = doneTodos.indexWhere((element) => mapEquals(element, doneTodo));
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }

  bool isTodoEmpty(Task task) {
    return task.todos == null || task.todos!.isEmpty;
  }

  int getDoneTodo(Task task) {
    var res = 0;
    for (int i = 0; i < task.todos!.length; i++) {
      if (task.todos![i]['done'] == true) {
        res += 1;
      }
    }
    return res;
  }

  void changeTabIndex(int value) {
    tabIndex.value = value;
  }

  int getTotalTasks() {
    var res = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        res += tasks[i].todos!.length;
      }
    }
    return res;
  }

  int getTotalDoneTasks() {
    var res = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        for (int j = 0; j < tasks[i].todos!.length; j++) {
          if (tasks[i].todos![j]['done'] == true) {
            res += 1;
          }
        }
      }
    }
    return res;
  }
}
