import 'package:maids_test/home_page/domain/entities/breeds_entity.dart';
import 'package:maids_test/home_page/presentation/bloc/home_page_bloc.dart';
import 'package:maids_test/home_page/presentation/bloc/home_page_state.dart';
import 'package:maids_test/home_page/presentation/widgets/app_bar.dart';
import 'package:maids_test/home_page/presentation/widgets/breeds_drop_down.dart';
import 'package:maids_test/home_page/presentation/widgets/filter.dart';
import 'package:maids_test/home_page/presentation/widgets/images_slider.dart';
import 'package:maids_test/home_page/presentation/widgets/submit_button.dart';

import 'package:maids_test/injection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ImageOptions { image, images }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageBloc homePageBloc = sl<HomePageBloc>();
  List<String> dogsImages = [];
  List<String> breeds = [];
  List<String> subBreeds = [];
  String? selectedBreedOption;
  String? selectedSubBreedOption;
  BreedsEntity? breedsEntity;
  bool withSubBreed = false;
  late String imagesNumber;
  ImageOptions image = ImageOptions.image;
  ImageOptions images = ImageOptions.images;

  @override
  void initState() {
    imagesNumber = image.name; //setup the default option
    homePageBloc = sl<HomePageBloc>()..add(FetchDogsBreedsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: GeneralAppBar(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: 40.h,
        ),
        FilterSelection(
          option1: image.name,
          option2: images.name,
          getOption: (option) {
            if (option == images.name) {
              imagesNumber = images.name;
            } else {
              imagesNumber = image.name;
            }
          },
        ),
        SizedBox(
          height: 40.h,
        ),
        breedsDropDownnWidget(),
        SizedBox(
          height: 40.h,
        ),
        subBreedsDrowDownWidget(),
        SizedBox(
          height: 40.h,
        ),
        submitButton(),
        imageSlider()
      ]),
    );
  }

  Widget submitButton() {
    return BlocBuilder(
      bloc: homePageBloc,
      builder: (context, state) {
        return SubmitButton(
            key: const Key('submitButton'),
            text: 'submit',
            onPress: () {
              // to block press when data is fetched to improve performance
              if (selectedBreedOption != null) {
                if (state is! LoadingDogsState) {
                  homePageBloc.add(FetchDogsInfoEvent(
                      image: imagesNumber,
                      breed: selectedBreedOption!,
                      subBreed: selectedSubBreedOption));
                }
              }
            });
      },
    );
  }

  Widget imageSlider() {
    return BlocBuilder(
      bloc: homePageBloc,
      builder: (context, state) {
        if (state is LoadingDogsState) {
          return SizedBox(
            height: 50.h,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is DogsInfoFetchedState) {
          dogsImages = state.dogEntity.dogWithRandomImage != null
              ? dogsImages = [state.dogEntity.dogWithRandomImage!]
              : state.dogEntity.dogsWithAllImages!;
        }
        if (state is ErrorDogsInfoState) {
          return Text(state.error);
        }
        return ImagesSlider(
            key: const Key('imageSlider'), images: dogsImages);
      },
    );
  }

  Widget breedsDropDownnWidget() {
    return BlocBuilder(
        bloc: homePageBloc,
        builder: (context, state) {
          if (state is LoadingBreeds) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DogsBreedsFetchedState) {
            breeds = state.breedsEntity.breeds.keys.toList();
          }
          if (state is ErrorBreedState) {
            return Text(state.error);
          }

          return BreedsDropdown(
            key: const Key('breedsDropDown'),
            items: breeds,
            onSelect: (selectedBreed) {
              homePageBloc.add(FetchDogsSubBreedsEvent(breed: selectedBreed));
              selectedBreedOption = selectedBreed;
              selectedSubBreedOption = null;
            },
          );
        });
  }

  Widget subBreedsDrowDownWidget() {
    return BlocBuilder(
      bloc: homePageBloc,
      builder: (context, state) {
        if (state is DogsSubBreedsFetchedState) {
          subBreeds = state.subBreeds;
        }
        return BreedsDropdown(
            key: const Key('subBreedsDropDown'),
            onSelect: (selectedSubBreed) {
              selectedSubBreedOption = selectedSubBreed;
            },
            items: subBreeds);
      },
    );
  }
}
