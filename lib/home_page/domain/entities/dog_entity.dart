import 'package:equatable/equatable.dart';

class DogEntity extends Equatable {
  final List<String>? dogsWithAllImages;
  final String status;

  final String? dogWithRandomImage;

  const DogEntity(
      {required this.dogsWithAllImages,
      required this.status,
      required this.dogWithRandomImage});

  @override
  List<Object?> get props => [status, dogsWithAllImages, dogWithRandomImage];
}
