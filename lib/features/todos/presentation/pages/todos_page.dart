import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids_test/core/widgets/loading.dart';
import 'package:maids_test/core/widgets/snackbar.dart';
import 'package:maids_test/features/todos/domain/entities/todo_entity.dart';
import 'package:maids_test/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:maids_test/features/todos/presentation/widgets/add_todo_alert.dart';
import 'package:maids_test/features/todos/presentation/widgets/todo_list_item.dart';
import 'package:maids_test/injection.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final ScrollController _scrollController = ScrollController();
  List<Todo> todos = [];
  int page = 1;
  TodosBloc todosBloc = sl<TodosBloc>();

  @override
  void initState() {
    todosBloc.add(FetchUserTodosEvent(page: page));
    super.initState();
  

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreTodos();
      }
    });
  }

  Future<void> _loadMoreTodos() async {
    page++;
    todosBloc.add(FetchUserTodosEvent(page: page));
  }

  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddTodoDialog(
          onAdd: (String text, bool isCompleted) {
            todosBloc.add(AddTodoEvent(text: text, completed: isCompleted,isLocal: true));
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 25.h,
            ),
            onPressed: _showAddTodoDialog,
          ),
        ],
        title: Text(
          'TODO List',
          style: TextStyle(fontSize: 14.sp),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer(
              bloc: todosBloc,
              builder: (BuildContext context, state) {
                if (state is LoadingTodosState && todos.isEmpty) {
                  return const LoadingWidget();
                }
                if (state is FetchedTodosState) {
                  if (todos.isEmpty) {
                    todos = state.todoModel.todos;
                  } else {
                    todos.addAll(state.todoModel.todos);
                  }
                }
                if (state is DeleteTodoSuccessState) {
                  todos.removeWhere((element) => element.id == state.todo.id);
                }
                if (state is UpdateTodoSuccessState) {
                  int index = todos
                      .indexWhere((element) => element.id == state.todo.id);
                  final updatedTodo = state.todo;
                  todos[index] = updatedTodo;
                }
                if (state is AddTodoSuccessState) {
             
                  todos.insert(0, state.todo);
        
                        
                }

                return ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: todos.length + 1,
                  itemBuilder: (context, index) {
                    if (index == todos.length) {
                      return state is LoadingTodosState
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : const SizedBox.shrink();
                    }
                    return TodoListItem(
                      todo: todos[index],
                      onTodoUpdated: (updatedTodo) {
                       
                       todosBloc.add(UpdateTodoEvent(todo: updatedTodo,));
                      },
                      onTodoDeleted: (todo) {
                       todosBloc.add(DeleteTodoEvent( todo: todo , ));
                      },
                    );
                  },
                );
              },
              listener: (BuildContext context, Object? state) {
                if (state is ErrorFetchingTodos) {
                  CustomSnackBar.showError(context, state.error);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
