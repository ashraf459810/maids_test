import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maids_test/core/const/const.dart';

import 'package:maids_test/features/auth/domain/usecases/user_usecase.dart';
import 'package:maids_test/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserUseCase useCase;
  AuthBloc(this.useCase) : super(AuthInitial()) {
    final cache = sl<SharedPreferences>();
    on<AuthEvent>((event, emit) async {

      if (event is LoginEvent) {
        emit(Loading());
        var response = await useCase.login(
          event.userName,
          event.password,
        );
        response.fold((l) => emit(Error(error: l.error!)), (r) {
          cache.setString(User.token, r.token);
           cache.setString(User.id, r.id.toString());
          emit(LoginSuccess());
        });
      }
    });
  }
}
