import 'dart:convert';
import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:maids_test/core/const/const.dart';
import 'package:maids_test/features/todos/domain/entities/todo_entity.dart';
import 'package:maids_test/features/todos/domain/usecases/todos_usecases.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends HydratedBloc<TodosEvent, TodosState> {
  List<Todo> todos = [];
  final TodosUseCase todosUseCase;
  final SharedPreferences sharedPreferences;
  TodosBloc(this.todosUseCase, this.sharedPreferences) : super(TodosInitial()) {
    on<TodosEvent>((event, emit) async {
      if (event is FetchUserTodosEvent) {
        emit(LoadingTodosState());
        var response = await todosUseCase.fetchUserTodos(event.skip,event.limit);

        response.fold((failure) {
          // Emit cached state if available, otherwise emit error state
          final String? cachedData = sharedPreferences.getString(User.todos);
          if (cachedData != null && cachedData.isNotEmpty) {
            todos = todosFromJson(cachedData);
            emit(FetchedTodosState(todos: todosFromJson(cachedData)));
          } else {
            emit(ErrorFetchingTodos(error: failure.error!));
          }
        }, (r) {
          if (todos.isEmpty) {
            todos = r.todos;
          } else {
            todos.addAll(r.todos);
          }

          emit(FetchedTodosState(todos: todos));
      
        });
      }
      if (event is AddTodoEvent) {
        emit(LoadingTodosState());
        if (event.isLocal) {
          todos.insert(
              0,
              Todo(
                  id: generateRandomId(),
                  todo: event.text,
                  completed: event.completed,
                  userId: sharedPreferences.getString(User.id),
                  isLocal: true));
          // this condition to check if is added to todo created by user locally because the apis dosen't support new todo crud
          emit(FetchedTodosState(todos: todos));
        } else {
          var response =
              await todosUseCase.addTodo(event.text, event.completed);
          response.fold((l) => emit(ErrorFetchingTodos(error: l.error!)), (r) {
            r.isLocal = true;
            emit(FetchedTodosState(todos: todos));
          });
        }
      }
      if (event is UpdateTodoEvent) {
        emit(LoadingTodosState());
        if (event.todo.isLocal ?? false) {
          addToTodos(event.todo);
          emit(FetchedTodosState(todos: todos));
        } else {
          var response = await todosUseCase.updateTodo(
              event.todo.id ?? 0, event.todo.completed);
          addToTodos(event.todo);
          response.fold((l) => emit(ErrorFetchingTodos(error: l.error!)),
              (r) => emit(FetchedTodosState(todos: todos)));
        }
      }
      if (event is DeleteTodoEvent) {
        emit(LoadingTodosState());
        if (event.todo.isLocal ?? false) {
          removeFromTodos(event.todo);
          emit(FetchedTodosState(todos: todos));
        } else {
          var response = await todosUseCase.deleteTodo(
            event.todo.id ?? 0,
          );
          removeFromTodos(event.todo);
          response.fold((l) => emit(ErrorFetchingTodos(error: l.error!)),
              (r) => emit(FetchedTodosState(todos: todos)));
        }
      }
    });
  }
@override
  TodosState? fromJson(Map<String, dynamic> json) {
    String? jsonTodos = sharedPreferences.getString(User.todos);
    if (jsonTodos != null) {
      final todos = todosFromJson(jsonTodos);

      return FetchedTodosState(todos: todos);
    } else {
      return null;
    }
  }
@override
  Map<String, dynamic>? toJson(TodosState state) {
    if (state is FetchedTodosState) {
      sharedPreferences.setString(User.todos, jsonEncode(state.todos));
    }

    return null;
  }

  void addToTodos(Todo todo) {
    int index = todos.indexWhere((element) => element.id == todo.id);
    final updatedTodo = todo;
    todos[index] = updatedTodo;
  }

  void removeFromTodos(Todo todo) {
    todos.removeWhere((element) => element.id == todo.id);
  }
}

int generateRandomId() {
  Random random = Random();
  int min = 10000; // Minimum value for the ID
  int max = 99999; // Maximum value for the ID
  return min + random.nextInt(max - min);
}
