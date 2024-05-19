import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maids_test/features/todos/domain/entities/todo_entity.dart';
import 'package:maids_test/features/todos/domain/repositories/todos_repository.dart';
import 'package:maids_test/features/todos/domain/usecases/todos_usecases.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


import 'todos_usecase_test.mocks.dart';



@GenerateMocks([
  TodosRepository,
])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  
  late MockTodosRepository mockTodosRepository;
  late TodosUseCase todosUseCase;
  late Todo todo;
  setUp(() {
    mockTodosRepository = MockTodosRepository();
    todosUseCase = TodosUseCaseImp(mockTodosRepository);
    todo = Todo(
      id: 1,
      todo: "text",
      completed: true,
    );
  });

  group('todos use cases test', () {
    test('should return todo when add todo use case completes successfully', () async {
      // Arrange
      when(mockTodosRepository.addTodo('text', true))
          .thenAnswer((_) async => Right(todo));

      // Act
      final result = await todosUseCase.addTodo("text", true);

      // Assert
      expect(result, Right(todo));
    });

    test('should return todo when update todo use case completes successfully',
        () async {
      // Arrange
      when(mockTodosRepository.updateTodo(1, true))
          .thenAnswer((_) async => Right(todo));

      // Act
      final result = await todosUseCase.updateTodo(1, true);

      // Assert
      expect(result, Right(todo));
    });

    test('should return todo when delete todo use case completes successfully',
        () async {
      // Arrange
      when(mockTodosRepository.deleteTodo(
        1,
      )).thenAnswer((_) async =>Right( todo));

      // Act
      final result = await todosUseCase.deleteTodo(
        1,
      );

      // Assert
      expect(result, Right(todo));
    });
  });
}
