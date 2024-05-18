// import 'package:maids_test/core/network_info/network_info.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'network_info_test.mocks.dart';

// @override
// @GenerateMocks([CheckInternetConnectivity])
// void main() {
//   final mockConnectivity = MockCheckInternetConnectivity();
//   NetworkInfImpl networkInfImpl;

//   test(
//     'test should return that you have internet on your device',
//     () async {
//       networkInfImpl = NetworkInfImpl(mockConnectivity);
//       // Arrange
//       when(mockConnectivity.checkInternetConnectivity())
//           .thenAnswer((_) => Future.value(true));

//       // Act
//       final result = await networkInfImpl.isConnected;

//       // Assert
//       verify(mockConnectivity.checkInternetConnectivity());
//       expect(result, true);
//     },
//   );
// }
