// To parse this JSON data, do
//
//     final todoEntity = todoEntityFromJson(jsonString);

import 'dart:convert';

import 'package:maids_test/features/todos/domain/entities/todo_entity.dart';

TodoModel todoModelFromJson(String str) => TodoModel.fromJson(json.decode(str));

String todoModelToJson(TodoModel data) => json.encode(data.toJson());

class TodoModel {
    List<Todo> todos;
    int total;
    dynamic skip;
    dynamic limit;
 
    TodoModel({
        required this.todos,
        required this.total,
        required this.skip,
        required this.limit,
   
    });

    factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        todos: List<Todo>.from(json["todos"].map((x) => Todo.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],  
    );

    Map<String, dynamic> toJson() => {
        "todos": List<dynamic>.from(todos.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
    };
}



