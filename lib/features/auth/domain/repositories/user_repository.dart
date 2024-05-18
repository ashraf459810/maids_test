import 'package:dartz/dartz.dart';
import 'package:maids_test/core/error/failures.dart';
import 'package:maids_test/features/auth/data/models/user_model.dart';


abstract class UserRepository {

Future<Either<Failure, UserModel>> login( String userName,String password);
}
