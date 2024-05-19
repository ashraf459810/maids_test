import 'package:dartz/dartz.dart';
import 'package:maids_test/core/error/failures.dart';
import 'package:maids_test/core/exception/app_exceptions.dart';
import 'package:maids_test/features/todos/data/datasources/todo_data_source.dart';
import 'package:maids_test/features/todos/data/models/todo_model.dart';
import 'package:maids_test/features/todos/domain/entities/todo_entity.dart';
import 'package:maids_test/features/todos/domain/repositories/todos_repository.dart';

class TodosRepositoryImp implements TodosRepository {
  final TodoRemoteDataSource todoRemoteDataSource;

  TodosRepositoryImp(
    this.todoRemoteDataSource,
  );

  @override
  Future<Either<Failure, TodoModel>> fetchTodos(int skip , int limit) async {
    try {
      final result = await todoRemoteDataSource.fetchUserTodos(skip,limit);

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e is AppException ? e.message : e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Todo>> addTodo(String text, bool completed) async {
       try {
      final result = await todoRemoteDataSource.addTodo(text,completed);

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e is AppException ? e.message : e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Todo>> deleteTodo(int id) async {
        try {
      final result = await todoRemoteDataSource.deleteTodo(id);

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e is AppException ? e.message : e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Todo>> updateTodo(int id, bool completed) async {
     try {
      final result = await todoRemoteDataSource.updateTodo(id, completed);

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e is AppException ? e.message : e.toString()));
    }
  }


}
