import 'package:dartz/dartz.dart';
import 'package:maids_test/core/error/failures.dart';
import 'package:maids_test/core/exception/app_exceptions.dart';
import 'package:maids_test/features/auth/data/datasources/user_remote_data.dart';
import 'package:maids_test/features/auth/data/models/user_model.dart';
import 'package:maids_test/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImp(
    this.userRemoteDataSource,
  );

  
  @override
  Future<Either<Failure, UserModel>> login(String mobileNumber, String password) async {
        try {
      final result =
          await userRemoteDataSource.login( mobileNumber, password);

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e is AppException ? e.message : e.toString()));
    }
  }
}
