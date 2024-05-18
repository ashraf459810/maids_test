import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? error;
  const Failure([this.error]);

  String getError() => error!;

  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure([super.error]);
}

class NetWorkFailure extends Failure {
  const NetWorkFailure([super.error]);
}

class ResponseError extends Failure {
  const ResponseError([super.error]);
}
