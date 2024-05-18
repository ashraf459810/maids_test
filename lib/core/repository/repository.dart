import 'package:dartz/dartz.dart';

abstract class Repository {

  Future<Either<dynamic ,dynamic >>getrequest(Function([String response]) model, String url);
    Future<Either<dynamic ,dynamic >>patchrequest(Function([String response]) model, String url);

  Future<Either<dynamic ,dynamic >>postrequest(Function([String response]) model, String url, [body]);
}