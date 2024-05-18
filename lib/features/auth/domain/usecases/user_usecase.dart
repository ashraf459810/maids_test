import 'package:dartz/dartz.dart';
import 'package:maids_test/features/auth/domain/entities/user_entity.dart';

import 'package:maids_test/features/auth/domain/repositories/user_repository.dart';

import '../../../../core/error/failures.dart';

abstract class UserUseCase {
  Future<Either<Failure, UserEntity>> login(
    String userName,
    String password,
  );
}

class UserUseCaseImp implements UserUseCase {
  final UserRepository userRepository;

  UserUseCaseImp(this.userRepository);

  @override
  Future<Either<Failure, UserEntity>> login(
      String userName, String password) async {
    return await userRepository.login(userName, password);
  }
}
