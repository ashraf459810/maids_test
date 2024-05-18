// import 'package:dartz/dartz.dart';
// import 'package:maids_test/home_page/data/datasources/dogs_remote_data.dart';
// import 'package:maids_test/home_page/data/models/breeds_model.dart';
// import 'package:maids_test/home_page/data/repositories/dogs_repository_imp.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import '../remote_data/dogs_remote_test.mocks.dart';
// import 'dogs_repository_test.mocks.dart';

// @override
// @GenerateMocks([DogsRemoteDataSource])
// void main() {
//   DogsRepositoryImp repository;
//   MockDogsRemoteDataSource mockDogsRemoteDataSource =
//       MockDogsRemoteDataSource();

//   MockNetworkInf mockNetworkInfo = MockNetworkInf();

//   repository = DogsRepositoryImp(
//     mockDogsRemoteDataSource,
//     mockNetworkInfo,
//   );

//   void runTestsOnline(Function body) {
//     group('device is online', () {
//       setUp(() {
//         when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
//       });

//       body();
//     });
//   }

//   const breedsModel = BreedsModel(
//     status: "success",
//     breeds: {
//       "breed1": ["sub1", "sub2"],
//       "breed2": ["sub3", "sub4"],
//       // Add more breeds as needed
//     },
//   );
//   runTestsOnline(() {
//     test(
//       'should check if the device is online',
//       () async {
//         // arrange
//         when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
//         // act
//         repository.fetchBreeds();
//         // assert
//         verify(mockNetworkInfo.isConnected);
//       },
//     );
//     test(
//       'should return remote data when the call to remote data source is successful',
//       () async {
//         // arrange
//         when(mockDogsRemoteDataSource.fetchBreeds())
//             .thenAnswer((_) async => breedsModel);
//         // act
//         final result = await repository.fetchBreeds();
//         // assert
//         verify(mockDogsRemoteDataSource.fetchBreeds());
//         expect(result, equals(const Right(breedsModel)));
//       },
//     );
//   });
// }
