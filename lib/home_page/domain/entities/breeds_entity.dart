import 'package:equatable/equatable.dart';

class BreedsEntity extends Equatable {
  final Map<String, List<String>> breeds;
  final String status;

  const BreedsEntity({
    required this.status,
    required this.breeds,
  });

  @override
  List<Object?> get props => [status, breeds];
}
