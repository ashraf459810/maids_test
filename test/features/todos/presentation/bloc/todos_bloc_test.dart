import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:maids_test/features/todos/data/models/todo_model.dart';
import 'package:maids_test/features/todos/domain/entities/todo_entity.dart';
import 'package:maids_test/features/todos/domain/usecases/todos_usecases.dart';
import 'package:maids_test/features/todos/presentation/bloc/todos_bloc.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


import 'package:shared_preferences/shared_preferences.dart';

import 'todos_bloc_test.mocks.dart';

@GenerateMocks([TodosUseCase, SharedPreferences ,])
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:  Directory.systemTemp.createTempSync(),
  );

  late MockTodosUseCase mockTodosUseCase;
  late MockSharedPreferences mockSharedPreferences;
  final todo1 = Todo(
    id: 1,
    todo: "text2",
    completed: true,
  );

  final todo2 = Todo(
    id: 2,
    todo: "text2",
    completed: true,
  );
  late List<Todo> todos = [todo1, todo2];
  setUp(() {
    mockTodosUseCase = MockTodosUseCase();
    mockSharedPreferences = MockSharedPreferences();
    when(mockSharedPreferences.getString(any)).thenReturn(todos.toString());
    when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);
  });

  group('bloc test', () {
    blocTest<TodosBloc, TodosState>(
      'emits [LoadingTodosState, FetchedTodosState] when FetchUserTodosEvent is added',
      build: () => TodosBloc(mockTodosUseCase, mockSharedPreferences),
      act: (bloc) {
        // Mock success response
        when(mockTodosUseCase.fetchUserTodos(
          1,
        )).thenAnswer((_) async =>
            Right(TodoModel(limit: 10, skip: 1, todos: todos, total: 10)));
        bloc.add(const FetchUserTodosEvent(page: 1));
      },
      expect: () => [
        LoadingTodosState(),
        FetchedTodosState(todos: todos),
      ],
    );
  });
}
