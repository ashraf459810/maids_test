import 'package:dartz/dartz.dart';
import 'package:maids_test/core/error/failures.dart';
import 'package:maids_test/features/todos/data/models/todo_model.dart';
import 'package:maids_test/features/todos/domain/entities/todo_entity.dart';


abstract class TodosRepository {

Future<Either<Failure, TodoModel>> fetchTodos(int skip , int limit);
  Future<Either<Failure, Todo>> addTodo(String text , bool completed);
  Future<Either<Failure, Todo>> updateTodo(int id, bool completed);
  Future<Either<Failure, Todo>> deleteTodo(int id );
}
