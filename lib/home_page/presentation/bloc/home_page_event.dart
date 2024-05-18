part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class FetchDogsBreedsEvent extends HomePageEvent {}

class FetchDogsSubBreedsEvent extends HomePageEvent {
  final String breed;

  const FetchDogsSubBreedsEvent({required this.breed});
}

class FetchDogsInfoEvent extends HomePageEvent {
  final String image;
  final String breed;
  final String? subBreed;

  const FetchDogsInfoEvent(
      {required this.image, required this.breed, required this.subBreed});
}  // for more params it is better to make a class for them