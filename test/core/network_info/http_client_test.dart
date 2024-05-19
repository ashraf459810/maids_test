import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:maids_test/core/exception/app_exceptions.dart';
import 'package:maids_test/core/network/connection_checker.dart';
import 'package:maids_test/core/network/http_helper.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:maids_test/core/network/http_helper_imp.dart';

import 'http_client_test.mocks.dart';



@GenerateMocks([Client, CheckInternetConnection])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockClient mockClient;
  late MockCheckInternetConnection mockCheckInternetConnection;
  late HttpHelper httpHelper;

  setUp(() {
    mockClient = MockClient();
    mockCheckInternetConnection = MockCheckInternetConnection();
    httpHelper = HttpHelperImp(mockClient, mockCheckInternetConnection);
  });

  group('HttpHelper', () {
    test('should return data if the http call completes successfully',
        () async {
      // Arrange
      when(mockCheckInternetConnection.hasInternetConnection())
          .thenAnswer((_) async => true);
      when(mockClient.get(Uri.parse('https://dummyjson.com/testUrl'),
              headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"message": "success"}', 200));

      // Act
      final result = await httpHelper.getRequest('/testUrl');

      // Assert
      expect(result, '{"message": "success"}');
    });

    test('should throw NoInternet if there is no connectivity', () async {
      // Arrange
      when(mockCheckInternetConnection.hasInternetConnection())
          .thenAnswer((_) async => false);

      // Act & Assert
      expect(httpHelper.getRequest('/testUrl'), throwsA(isA<NoInternet>()));
    });

    test('should throw BadRequestException if the response code is 400',
        () async {
      // Arrange
      when(mockCheckInternetConnection.hasInternetConnection())
          .thenAnswer((_) async => true);
      when(mockClient.get(Uri.parse('https://dummyjson.com/testUrl'),
              headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"message": "Bad Request"}', 400));

      // Act & Assert
      expect(httpHelper.getRequest('/testUrl'),
          throwsA(isA<BadRequestException>()));
    });

    test('should return data if the http post method called successfully',
        () async {
      // Arrange
      when(mockCheckInternetConnection.hasInternetConnection())
          .thenAnswer((_) async => true);
      when(mockClient.post(Uri.parse('https://dummyjson.com/testUrl',),
              headers: anyNamed('headers'),     body: jsonEncode({}),))
          .thenAnswer((_) async => Response('{"message": "success"}', 200));

      // Act
      final result = await httpHelper.postRequest('/testUrl', {});

      // Assert
      expect(result, '{"message": "success"}');
    });

    test('should return data if the http put method called successfully',
        () async {
      // Arrange
      when(mockCheckInternetConnection.hasInternetConnection())
          .thenAnswer((_) async => true);
      when(mockClient.put(Uri.parse('https://dummyjson.com/testUrl'),
              headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"message": "success"}', 200));

      // Act
      final result = await httpHelper.putRequest('/testUrl', {});

      // Assert
      expect(result, '{"message": "success"}');
    });

    test('should return data if the http delete method called successfully',
        () async {
      // Arrange
      when(mockCheckInternetConnection.hasInternetConnection())
          .thenAnswer((_) async => true);
      when(mockClient.delete(Uri.parse('https://dummyjson.com/testUrl'),
              headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"message": "success"}', 200));

      // Act
      final result = await httpHelper.deleteRequest(
        '/testUrl',
      );

      // Assert
      expect(result, '{"message": "success"}');
    });
  });
}
