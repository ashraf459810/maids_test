part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}



class FetchUserTodosEvent extends TodosEvent{
  final int page ;

  const FetchUserTodosEvent({required this.page});
}


class UpdateTodoEvent extends TodosEvent{
  final Todo todo;


  const UpdateTodoEvent({required this.todo,});
}


class DeleteTodoEvent extends TodosEvent{
  final Todo todo;
  
  const DeleteTodoEvent({required this.todo });
}


class AddTodoEvent extends TodosEvent{
  final String text;
  final bool completed;
final bool isLocal;
  const AddTodoEvent({required this.text, required this.completed, required this.isLocal});
}