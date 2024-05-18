import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:maids_test/core/const/const.dart';
import 'package:maids_test/features/todos/data/models/todo_model.dart';
import 'package:maids_test/features/todos/domain/entities/todo_entity.dart';
import 'package:maids_test/features/todos/domain/usecases/todos_usecases.dart';
import 'package:maids_test/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends HydratedBloc<TodosEvent, TodosState> {
  final TodosUseCase todosUseCase;
  TodosBloc(this.todosUseCase) : super(TodosInitial()) {
    on<TodosEvent>((event, emit) async {
      if (event is FetchUserTodosEvent) {
        emit(LoadingTodosState());
        var response = await todosUseCase.fetchUserTodos(event.page);
        response.fold((failure) {
          // Emit cached state if available, otherwise emit error state
          final String? cachedData =
              sl<SharedPreferences>().getString(User.todos);
          if (cachedData != null && cachedData.isNotEmpty) {
            final TodosState cachedState =
                FetchedTodosState(todoModel: todoModelFromJson(cachedData));
            emit(cachedState);
          } else {
            emit(ErrorFetchingTodos(error: failure.error!));
          }
        }, (r) => emit(FetchedTodosState(todoModel: r)));
      }
      if (event is AddTodoEvent) {
        emit(LoadingTodosState());
        if (event.isLocal) {
          // this condition to check if is added to todo created by user locally because the apis dosen't support new todo crud
          emit(AddTodoSuccessState(
              todo: Todo(
                  id: generateRandomId(),
                  todo: event.text,
                  completed: event.completed,
                  userId: sl<SharedPreferences>().getString(User.id),
                  isLocal: true)));

        } else {
          var response =
              await todosUseCase.addTodo(event.text, event.completed);
          response.fold((l) => emit(ErrorFetchingTodos(error: l.error!)), (r) {
            r.isLocal = true;
            emit(AddTodoSuccessState(todo: r));
          });
        }
      }
      if (event is UpdateTodoEvent) {
        emit(LoadingTodosState());
        if (event.todo.isLocal) {
          emit(UpdateTodoSuccessState(
              todo: Todo(
                  id: event.todo.id,
                  todo: event.todo.todo,
                  completed: event.todo.completed,
                  userId: event.todo.userId,
                  isLocal: true)));
        } else {
          var response = await todosUseCase.updateTodo(
              event.todo.id, event.todo.completed);
          response.fold((l) => emit(ErrorFetchingTodos(error: l.error!)),
              (r) => emit(UpdateTodoSuccessState(todo: r)));
        }
      }
      if (event is DeleteTodoEvent) {
        emit(LoadingTodosState());
        if (event.todo.isLocal) {
          emit(DeleteTodoSuccessState(
              todo: Todo(
                  id: event.todo.id,
                  todo: event.todo.todo,
                  completed: event.todo.completed,
                  userId: event.todo.userId,
                  isLocal: true)));
        } else {
          var response = await todosUseCase.deleteTodo(
            event.todo.id,
          );
          response.fold((l) => emit(ErrorFetchingTodos(error: l.error!)),
              (r) => emit(DeleteTodoSuccessState(todo: r)));
        }
      }
    });
  }

  @override
  TodosState? fromJson(Map<String, dynamic> json) {
    String? jsonTodos = sl<SharedPreferences>().getString(User.todos);
    if (jsonTodos != null) {
      final todos = todoModelFromJson(jsonTodos);

      return FetchedTodosState(todoModel: todos);
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(TodosState state) {
    if (state is FetchedTodosState) {
      sl<SharedPreferences>()
          .setString(User.todos, jsonEncode(state.todoModel));
    }
    if (state is AddTodoSuccessState){}
    return null;
  }
}

int generateRandomId() {
  Random random = Random();
  int min = 10000; // Minimum value for the ID
  int max = 99999; // Maximum value for the ID
  return min + random.nextInt(max - min);
}
