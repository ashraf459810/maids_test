// import 'package:maids_test/core/network_info/network_info.dart';
// import 'package:maids_test/core/remote_data_function/http_methods.dart';
// import 'package:maids_test/home_page/data/models/breeds_model.dart';
// import 'package:maids_test/home_page/data/models/dog_model.dart';
// import 'package:maids_test/home_page/presentation/pages/home_page.dart';

// abstract class DogsRemoteDataSource {
//   Future<BreedsModel> fetchBreeds();
//   Future<DogModel> fetchDogsInfo(
//       String imageNumber, String breed, String? subBreed);
// }

// class DogsRemoteDataSourceImp implements DogsRemoteDataSource {
//   final HttpFunctions httpFunctions;
//   final NetworkInf networkInf;

//   DogsRemoteDataSourceImp(this.networkInf, this.httpFunctions);
//   @override
//   Future<BreedsModel> fetchBreeds() async {
//     final breeds = await httpFunctions.getMethod(
//         baseurl: networkInf.baseUrl, url: "/breeds/list/all");

//     return breedsModelFromJson(breeds.body);
//   }

//   @override
//   Future<DogModel> fetchDogsInfo(
//       String imageNumber, String breed, String? subBreed) async {
//     final subBreedSegment = subBreed != null
//         ? '/$subBreed'
//         : ''; // if subBreed selected /$subBreed will be added to the url otherwise nothing and the url will bring the data belomg to breed only
//     final imagesNumberSegment = imageNumber == ImageOptions.image.name
//         ? '/random'
//         : ''; // if image option is only one the /random will be added to url otherwise nothing will be added to url and i will get list of images

//     final breeds = await httpFunctions.getMethod(
//         baseurl: networkInf.baseUrl,
//         url: "/breed/$breed$subBreedSegment/images$imagesNumberSegment");

//     return imageNumber == ImageOptions.image.name
//         ? dogModelFromJsonWithOneImage(breeds.body)
//         : dogModelFromJsonWithMultiImages(breeds
//             .body); //dogModel has 2 fromjson method according to the data , another option was to make a new feature for this cases
//   }
// }
