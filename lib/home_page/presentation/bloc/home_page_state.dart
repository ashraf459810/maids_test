import 'package:maids_test/home_page/domain/entities/breeds_entity.dart';
import 'package:maids_test/home_page/domain/entities/dog_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_page_state.freezed.dart';

@freezed
 class HomePageState with _$HomePageState {
  const factory HomePageState.homePageInitial() = HomePageInitial;
  const factory HomePageState.loadingBreeds() = LoadingBreeds;
  const factory HomePageState.loadingSubBreeds() = LoadingSubBreeds;
  const factory HomePageState.errorBreedState({required String error}) = ErrorBreedState;
  const factory HomePageState.dogsBreedsFetchedState({required BreedsEntity breedsEntity}) = DogsBreedsFetchedState;
  const factory HomePageState.dogsSubBreedsFetchedState({required List<String> subBreeds}) = DogsSubBreedsFetchedState;
  const factory HomePageState.dogsInfoFetchedState({required DogEntity dogEntity}) = DogsInfoFetchedState;
  const factory HomePageState.loadingDogsState() = LoadingDogsState;
  const factory HomePageState.errorDogsInfoState({required String error}) = ErrorDogsInfoState;
}
