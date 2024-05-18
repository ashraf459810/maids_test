
import 'package:maids_test/core/network/http_helper.dart';
import 'package:maids_test/features/auth/data/models/user_model.dart';


abstract class UserRemoteDataSource {
  Future<UserModel> login(
    String userName,
    String password,
  );
}

class UserRemoteDataSourceImp extends UserRemoteDataSource {
  final HttpHelper httpHelper;

  UserRemoteDataSourceImp({required this.httpHelper});

  @override
  Future<UserModel> login(
    String userName,
    String password,
  ) async {
    final response = await httpHelper.postRequest(
        '/auth/login', {"password": password, "username": userName});

    final user = userModelFromJson(response);

    return user;
  }
}
