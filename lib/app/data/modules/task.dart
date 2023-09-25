import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? todos;
  const Task(
      {required this.title,
      required this.icon,
      required this.color,
      this.todos});
  //every class needs a constant constructor
  // but in our app that means that we cant change the task if we needed to
  // so for this, we create a new constructor copywith
  // that will change the details of our task and later replace paila ko task
  // this is how modification will be done, we use the equatable library

  Task copyWith({
    String? title,
    int? icon,
    String? color,
    List<dynamic>? todos,
  }) =>
      Task(
          title: title ?? this.title,
          icon: icon ?? this.icon,
          color: color ?? this.color,
          todos: todos ?? this.todos);
  //they are optional because if for eg. title is not passed, we will use the older title as our argument

  // this is a named constructor that we are making
  // it will be used in order to retreive the data from the json file
  // in that file we will be storing our tasks
  factory Task.fromJson(Map<String, dynamic> json) => Task(
      title: json['title'],
      icon: json['icon'],
      color: json['color'],
      todos: json['todos']);

  // this is the function that will do the serialization of the tasks
  // using the map that it returns, we can add the map to our json file
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': icon,
      'color': color,
      'todos': todos,
    };
  }

  // using these 3 properties we will compare the tasks
  // instead of directly comparing classes (which wouldalways return false)
  // we compare the values using the equatable library
  @override
  List<Object> get props => [title, icon, color];
}
