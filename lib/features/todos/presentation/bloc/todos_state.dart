part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();  

  @override
  List<Object> get props => [];
}
class TodosInitial extends TodosState {}


class LoadingTodosState extends TodosState{}


class FetchedTodosState extends TodosState{
  final TodoModel todoModel;

  const FetchedTodosState({required this.todoModel});

}

class ErrorFetchingTodos extends TodosState{
  final String error ;

  const ErrorFetchingTodos({required this.error});
}


class UpdateTodoSuccessState extends TodosState{
  final Todo todo;

  const UpdateTodoSuccessState({required this.todo});
}


class DeleteTodoSuccessState extends TodosState{
  final Todo todo;

  const DeleteTodoSuccessState({required this.todo});
}

class AddTodoSuccessState extends TodosState{
  final Todo todo;

  const AddTodoSuccessState({required this.todo});
}