import 'package:dartz/dartz.dart';

import '../repository/repository.dart';


abstract class UseCase {
  Future<Either<dynamic, dynamic>> getUsecase(
      String url, Function([String? response]) model);

  Future<Either<dynamic, dynamic>> patchUsecase(
    String url,
    Function([String? response]) model,
  );

  Future<Either<dynamic, dynamic>> postUsecase(
      String url, Function([String? response]) model, body);
}

class UseCaseImp implements UseCase {
  final Repository repository;

  UseCaseImp(this.repository);

  @override
  Future<Either<dynamic, dynamic>> getUsecase(
      String url, Function([String response]) model) async {
    return await repository.getrequest(model, url);
  }

  @override
  Future<Either<dynamic, dynamic>> postUsecase(
      String url, Function([String response]) model, body) async {
    return await repository.postrequest(model, url, body);
  }

  @override
  Future<Either> patchUsecase(
      String url, Function([String? response]) model) async {
    return await repository.patchrequest(model, url);
  }
}
