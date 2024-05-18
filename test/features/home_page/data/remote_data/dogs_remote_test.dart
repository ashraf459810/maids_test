// import 'package:maids_test/core/network_info/network_info.dart';
// import 'package:maids_test/core/remote_data_function/http_methods.dart';
// import 'package:maids_test/home_page/data/datasources/dogs_remote_data.dart';
// import 'package:maids_test/home_page/data/models/breeds_model.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:http/http.dart' as http;

// import 'dogs_remote_test.mocks.dart';

// @override
// @GenerateMocks([HttpFunctions])
// @override
// @GenerateMocks([NetworkInf])
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

// // mocked dependencies
//   MockHttpFunctions mockHttpFunctions = MockHttpFunctions();
//   MockNetworkInf mockNetworkInf = MockNetworkInf();

//   DogsRemoteDataSourceImp dogsRemoteDataSourceImp =
//       DogsRemoteDataSourceImp(mockNetworkInf, mockHttpFunctions);

//   Future<String> breedsModel() async {
//     final breeds = await rootBundle.loadString("test/breed_model/breeds.json");
//     return breeds;
//   }

//   final breedModel = await breedsModel();

//   void setUpMockHttpFunctionstSuccess200() {
//     when(mockNetworkInf.baseUrl).thenReturn('https://dog.ceo/api');
//     when(mockHttpFunctions.getMethod(
//             url: '/breeds/list/all', baseurl: 'https://dog.ceo/api'))
//         .thenAnswer((_) async => http.Response(breedModel, 200));
//   }

//   test(
//     'should return breeds when the response code is 200 (success)',
//     () async {
//       // arrange
//       final breedsModel = breedsModelFromJson((breedModel));
//       setUpMockHttpFunctionstSuccess200();

//       // act
//       final result = await dogsRemoteDataSourceImp.fetchBreeds();
//       // assert
//       expect(result, equals(breedsModel));
//     },
//   );
// }
