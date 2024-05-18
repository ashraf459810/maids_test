



import 'dart:math';

import 'package:maids_test/core/const/const.dart';
import 'package:maids_test/core/network/http_helper.dart';
import 'package:maids_test/features/todos/data/models/todo_model.dart';
import 'package:maids_test/features/todos/domain/entities/todo_entity.dart';
import 'package:maids_test/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TodoRemoteDataSource {
  Future<TodoModel> fetchUserTodos(int page);
  Future<Todo> addTodo(String text , bool completed);
  Future<Todo> updateTodo(int id, bool completed);
  Future<Todo> deleteTodo(int id );
}

class TodoRemoteDataSourceImp extends TodoRemoteDataSource {
  final HttpHelper httpHelper;

  TodoRemoteDataSourceImp({required this.httpHelper});

  @override
  Future<TodoModel> fetchUserTodos(int page) async {
    final response = await httpHelper.getRequest('/todos?limit=10&skip=$page');

    final todos = todoModelFromJson(response);

    return todos;
  }
  
  @override
  Future<Todo> addTodo(String text, bool completed) async {
   final response = await httpHelper.postRequest('/todos/add' , {"todo":text, "completed":completed,"userId":sl<SharedPreferences>().getString(User.id)});
    final todo = todoFromJson(response);

    return todo;
  }
  
  @override
  Future<Todo> deleteTodo(int id) async {
   final response = await httpHelper.deleteRequest('/todos/$id' );

    final todo = todoFromJson(response);

    return todo;
  }
  
  @override
  Future<Todo> updateTodo(int id, bool completed) async {

   final response = await httpHelper.putRequest('/todos/$id', {"completed": completed});

    final todo = todoFromJson(response);

    return todo;
}
}