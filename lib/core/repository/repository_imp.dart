


import 'dart:developer';


import 'package:dartz/dartz.dart';
import 'package:maids_test/core/exception/app_exceptions.dart';
import 'package:maids_test/core/repository/repository.dart';

import '../network/http_helper.dart';






class RepositoryImp implements Repository{
  final HttpHelper httpHelper;

  RepositoryImp(this.httpHelper);

  @override
  Future<Either<dynamic, dynamic>> getrequest(Function([String response]) model, String url) async {
    try {
       var response = await httpHelper.getRequest(url);
    log(response);
    var decodeddata = model(response);

    return Right(decodeddata);}
    catch( e){
log(e.toString());
      return Left(e is AppException ? e.message : e.toString());
    }
  }

  @override
  Future<Either<dynamic, dynamic>> postrequest(Function([String response]) model, String url, [body]) async {
       try {
       var response = await httpHelper.postRequest(url,body);
   log(response);
    var decodeddata = model(response);
   
    return Right(decodeddata);}
    catch(e){
          log(e.toString());
      return Left(e);
    }
  }

  @override
  Future<Either> patchrequest(Function([String response]) model, String url,[body]) async {
       try {
       var response = await httpHelper.putRequest(url,body);
   log(response);
    var decodeddata = model(response);
   
    return Right(decodeddata);}
    catch(e){
  
      return Left(e);
    }
  }
}

