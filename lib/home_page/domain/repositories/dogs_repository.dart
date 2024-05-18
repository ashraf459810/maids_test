import 'package:dartz/dartz.dart';
import 'package:maids_test/core/error/failures.dart';
import 'package:maids_test/home_page/data/models/dog_model.dart';
import 'package:maids_test/home_page/domain/entities/breeds_entity.dart';

abstract class DogsRepository {
  Future<Either<Failure, BreedsEntity>> fetchBreeds();
  Future<Either<Failure, DogModel>> fetchDogsInfo(
      String imageNumber, String breed, String? subBreed);
}
