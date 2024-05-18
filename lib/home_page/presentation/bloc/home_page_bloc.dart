import 'package:maids_test/home_page/domain/entities/breeds_entity.dart';
import 'package:maids_test/home_page/domain/usecases/dogs_breed_use_case.dart';

import 'package:maids_test/home_page/domain/usecases/dogs_info_use_case.dart';
import 'package:maids_test/home_page/presentation/bloc/home_page_state.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_page_event.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final DogsBreedUseCase dogsBreedUseCase;
  final DogsImageUseCase dogsInfoUseCase;
  HomePageBloc(this.dogsBreedUseCase, this.dogsInfoUseCase)
      : super(const HomePageState.homePageInitial()) {
    BreedsEntity? breedsEntity;

    on<HomePageEvent>((event, emit) async {
      if (event is FetchDogsBreedsEvent) {
        emit(const HomePageState.loadingBreeds());
        final breeds = await dogsBreedUseCase.fetchBreeds();
        breeds.fold(
            (l) => HomePageState.errorDogsInfoState(error: l.error ?? ''), (r) {
          breedsEntity = r;
          emit(DogsBreedsFetchedState(breedsEntity: r));
        });
      }
      if (event is FetchDogsSubBreedsEvent) {
        emit(const HomePageState.loadingSubBreeds());
        await Future.delayed(const Duration(milliseconds: 20));
        if (breedsEntity?.breeds.containsKey(event.breed) ?? false) {
          var subBreeds = breedsEntity!.breeds[event.breed]!.cast<String>();

          emit(HomePageState.dogsSubBreedsFetchedState(subBreeds: subBreeds));
        }
      }
      if (event is FetchDogsInfoEvent) {
        emit(const HomePageState.loadingDogsState());
        final breeds = await dogsInfoUseCase.fetchDogsInfo(
            event.image, event.breed, event.subBreed);
        breeds.fold(
            (l) => emit(HomePageState.errorDogsInfoState(error: l.error ?? '')),
            (r) {
          emit(HomePageState.dogsInfoFetchedState(dogEntity: r));
        });
      }
    });
  }
}
