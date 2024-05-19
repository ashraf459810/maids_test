import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:maids_test/features/todos/data/datasources/todo_data_source.dart';
import 'package:maids_test/features/todos/data/repositories/todos_repository_imp.dart';
import 'package:maids_test/features/todos/domain/entities/todo_entity.dart';
import 'package:maids_test/features/todos/domain/repositories/todos_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'todos_repository_test.mocks.dart';

@GenerateMocks([
  TodoRemoteDataSource,
])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockTodoRemoteDataSource mockTodoRemoteDataSource;
  late TodosRepository todosRepository;
  late Todo todo;
  setUp(() {
    mockTodoRemoteDataSource = MockTodoRemoteDataSource();
    todosRepository = TodosRepositoryImp(mockTodoRemoteDataSource);
    todo = Todo(
      id: 1,
      todo: "text",
      completed: true,
    );
  });

  group('todos Respository test', () {
    test('should return todo when add todo completes successfully', () async {
      // Arrange
      when(mockTodoRemoteDataSource.addTodo('text', true))
          .thenAnswer((_) async => todo);

      // Act
      final result = await todosRepository.addTodo("text", true);

      // Assert
      expect(result, Right(todo));
    });

    test('should return todo when update todo completes successfully',
        () async {
      // Arrange
      when(mockTodoRemoteDataSource.updateTodo(1, true))
          .thenAnswer((_) async => todo);

      // Act
      final result = await todosRepository.updateTodo(1, true);

      // Assert
      expect(result, Right(todo));
    });

    test('should return todo when delete todo completes successfully',
        () async {
      // Arrange
      when(mockTodoRemoteDataSource.deleteTodo(
        1,
      )).thenAnswer((_) async => todo);

      // Act
      final result = await todosRepository.deleteTodo(
        1,
      );

      // Assert
      expect(result, Right(todo));
    });
  });
}
