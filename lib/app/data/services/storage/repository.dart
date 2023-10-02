// this will have the acces to our provider
import 'package:to_do_list/app/data/providers/task/provider.dart';
import 'package:to_do_list/app/data/modules/task.dart';

class TaskRepository {
  TaskRepository({required this.taskProvider});
  TaskProvider taskProvider;

  List<Task> readTasks() => taskProvider.readTasks();
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
