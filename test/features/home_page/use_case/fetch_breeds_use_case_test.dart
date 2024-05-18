import 'package:dartz/dartz.dart';
import 'package:maids_test/home_page/data/models/breeds_model.dart';
import 'package:maids_test/home_page/domain/repositories/dogs_repository.dart';
import 'package:maids_test/home_page/domain/usecases/dogs_breed_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fetch_breeds_use_case_test.mocks.dart';

@override
@GenerateMocks([DogsRepository])
void main() {
  DogsBreedUseCaseImp dogsBreedUseCase;
  MockDogsRepository mockDogsRepository = MockDogsRepository();

  dogsBreedUseCase = DogsBreedUseCaseImp(mockDogsRepository);

  const breedsModel = BreedsModel(
    status: "success",
    breeds: {
      "breed1": ["sub1", "sub2"],
      "breed2": ["sub3", "sub4"],
      // Add more breeds as needed
    },
  );

  test(
    'rub dogs breeds use case should get dogs breeds from the repository',
    () async {
      // arrange
      when(mockDogsRepository.fetchBreeds())
          .thenAnswer((_) async => const Right(breedsModel));
      // act
      final result = await dogsBreedUseCase.fetchBreeds();
      // assert
      expect(result, const Right(breedsModel));
      verify(mockDogsRepository.fetchBreeds());
      verifyNoMoreInteractions(mockDogsRepository);
    },
  );
}
