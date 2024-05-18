import 'package:dartz/dartz.dart';
import 'package:maids_test/core/error/failures.dart';
import 'package:maids_test/home_page/domain/entities/breeds_entity.dart';
import 'package:maids_test/home_page/domain/repositories/dogs_repository.dart';

abstract class DogsBreedUseCase {
  Future<Either<Failure, BreedsEntity>> fetchBreeds();
}

class DogsBreedUseCaseImp implements DogsBreedUseCase {
  final DogsRepository dogsRepository;

  DogsBreedUseCaseImp(this.dogsRepository);

  @override
  Future<Either<Failure, BreedsEntity>> fetchBreeds() async {
    return await dogsRepository.fetchBreeds();
  }
}
