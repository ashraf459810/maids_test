import 'dart:convert';

Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

class Todo {
  int? id;
  String todo;
  bool completed;
  dynamic userId;
  bool? isLocal;   // this parameter is added to check if the todo created by user locally because the api dosn't support add new todo
  Todo(
      { this.id,
      required this.todo,
      required this.completed,
       this.userId,
       this.isLocal});

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        todo: json["todo"],
        completed: json["completed"],
        userId: json["userId"],
        isLocal: json['isLocal']??false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "todo": todo,
        "completed": completed,
        "userId": userId,
        "isLocal" :isLocal
      };
}

List<Todo> todosFromJson(String str) {
  final Iterable<dynamic> parsed = json.decode(str);
  return List<Todo>.from(parsed.map((json) => Todo.fromJson(json)));
}
