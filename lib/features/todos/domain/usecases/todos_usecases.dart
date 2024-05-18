import 'package:dartz/dartz.dart';
import 'package:maids_test/features/todos/data/models/todo_model.dart';
import 'package:maids_test/features/todos/domain/entities/todo_entity.dart';
import 'package:maids_test/features/todos/domain/repositories/todos_repository.dart';
import '../../../../core/error/failures.dart';

abstract class TodosUseCase {
  Future<Either<Failure, TodoModel>> fetchUserTodos(int page);
    Future<Either<Failure, Todo>> addTodo(String text , bool completed);
  Future<Either<Failure, Todo>> updateTodo(int id, bool completed);
  Future<Either<Failure, Todo>> deleteTodo(int id );
}

class TodosUseCaseImp implements TodosUseCase {
  final TodosRepository todosRepository;

  TodosUseCaseImp(this.todosRepository);

  @override
  Future<Either<Failure, TodoModel>> fetchUserTodos(int page) async {
    return await todosRepository.fetchTodos(page);
  }
  
  @override
  Future<Either<Failure, Todo>> addTodo(String text, bool completed) async {
      return await todosRepository.addTodo(text, completed);
  }
  
  @override
  Future<Either<Failure, Todo>> deleteTodo(int id) async {
      return await todosRepository.deleteTodo(id,);
  }
  
  @override
  Future<Either<Failure, Todo>> updateTodo(int id, bool completed) async {
    return await todosRepository.updateTodo(id, completed);
  }
}
