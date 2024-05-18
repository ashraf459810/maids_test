import 'dart:convert';

import 'package:maids_test/home_page/domain/entities/dog_entity.dart';

DogModel dogModelFromJsonWithOneImage(String str) =>
    DogModel.fromJsonwWithOneImage(json.decode(str));

DogModel dogModelFromJsonWithMultiImages(String str) =>
    DogModel.fromJsonWithMultiImages(json.decode(str));

class DogModel extends DogEntity {
  const DogModel({
    required List<String>? dogsWithAllImages,
    required String? dogsWithRandomImage,
    required String status,
  }) : super(
            status: status,
            dogWithRandomImage: dogsWithRandomImage,
            dogsWithAllImages: dogsWithAllImages);

  factory DogModel.fromJsonwWithOneImage(Map<String, dynamic> json) => DogModel(
      dogsWithAllImages: null,
      status: json["status"],
      dogsWithRandomImage: json['message']);
  factory DogModel.fromJsonWithMultiImages(Map<String, dynamic> json) =>
      DogModel(
          dogsWithAllImages: List<String>.from(json["message"].map((x) => x)),
          status: json["status"],
          dogsWithRandomImage: null);
}
