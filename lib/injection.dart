
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:maids_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:maids_test/features/auth/data/datasources/user_remote_data.dart';
import 'package:maids_test/features/auth/data/repositories/user_repository_imp.dart';
import 'package:maids_test/features/auth/domain/repositories/user_repository.dart';
import 'package:maids_test/features/auth/domain/usecases/user_usecase.dart';
import 'package:maids_test/features/todos/data/datasources/todo_data_source.dart';
import 'package:maids_test/features/todos/data/repositories/todos_repository_imp.dart';
import 'package:maids_test/features/todos/domain/repositories/todos_repository.dart';
import 'package:maids_test/features/todos/domain/usecases/todos_usecases.dart';
import 'package:maids_test/features/todos/presentation/bloc/todos_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/http_helper.dart';
import 'core/navigatuin_service/navigation.dart';
import 'core/network/http_helper_imp.dart';
import 'core/repository/repository.dart';
import 'core/repository/repository_imp.dart';
import 'core/use_case/use_case.dart';

final sl = GetIt.instance;

Future iniGetIt() async {
//bloc
sl.registerFactory<AuthBloc>(() => AuthBloc( sl(), ));
sl.registerFactory<TodosBloc>(() => TodosBloc( sl(), ));

//remote data
 sl.registerFactory<UserRemoteDataSource>(() => UserRemoteDataSourceImp( httpHelper: sl()));
 sl.registerFactory<TodoRemoteDataSource>(() => TodoRemoteDataSourceImp( httpHelper: sl()));

 //respository
 sl.registerLazySingleton<UserRepository>(() => UserRepositoryImp(sl()));
 sl.registerLazySingleton<TodosRepository>(() => TodosRepositoryImp(sl()));

 //use case
  sl.registerLazySingleton<UserUseCase>(() => UserUseCaseImp(sl()));
  sl.registerLazySingleton<TodosUseCase>(() => TodosUseCaseImp(sl()));

 // utilities
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => NavigationService());
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton<HttpHelper>(() => HttpHelperImp(sl()));
  sl.registerLazySingleton<Repository>(() => RepositoryImp(sl()));
  sl.registerLazySingleton<UseCase>(() => UseCaseImp(
        sl(),
      ));
}
