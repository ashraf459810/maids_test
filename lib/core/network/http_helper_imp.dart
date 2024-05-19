import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:maids_test/core/network/connection_checker.dart';
import '../exception/app_exceptions.dart';
import 'http_helper.dart';

class HttpHelperImp implements HttpHelper {
  final Client client;
  final CheckInternetConnection checkInternetConnection;
  final String _baseUrl = "https://dummyjson.com";

  HttpHelperImp(this.client, this.checkInternetConnection);

  @override
  Future getRequest(String url) async {
    dynamic responseJson;

    if (await checkInternetConnection.hasInternetConnection()) {
      final response = await client.get(Uri.parse(_baseUrl + url), headers: {
        'Content-Type': 'application/json',
      });

      log(_baseUrl + url);
      log(response.statusCode.toString());
      log(response.body);
      responseJson = returnResponse(response);

      return responseJson;
    } else {
      throw NoInternet('no internet conecction');
    }
  }

  @override
  Future postRequest(String url, [body]) async {

    dynamic responseJson;

    if (await checkInternetConnection.hasInternetConnection()) {
      final response = await client
          .post(Uri.parse(_baseUrl + url), body: jsonEncode(body), headers: {
        'Content-Type': 'application/json',
      });
      log(_baseUrl + url);
      log(response.statusCode.toString());
      log(response.body);

      responseJson = returnResponse(response);

      return responseJson;
    } else {
      throw NoInternet('no internet conecction');
    }
  }

  @override
  returnResponse(Response response) {
    dynamic jsonResponse = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        var responseinjson = (response.body);
        return responseinjson;
      case 201:
        var responseinjson = (response.body);
        return responseinjson;
      case 400:
        throw BadRequestException((jsonResponse["message"]));
      case 401:
        throw UnauthorisedException(jsonResponse["message"]);
      case 403:
        throw UnauthorisedException(jsonResponse["message"]);
      case 404:
        throw NoInternet("status 404 :: Not Found");
      case 500:
        throw InternalServerError((jsonResponse["message"]));

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  @override
  Future putRequest(String url, [body]) async {
    log(_baseUrl + url);

    dynamic responseJson;

    if (await checkInternetConnection.hasInternetConnection()) {
      final response = await client.put(
          Uri.parse(
            _baseUrl + url,
          ),
          headers: {
            'Content-Type': 'application/json',
          });
      log(_baseUrl + url);
      log(response.statusCode.toString());
      log(response.body);

      responseJson = returnResponse(response);

      return responseJson;
    } else {
      throw NoInternet('no internet conecction');
    }
  }

  @override
  Future deleteRequest(String url) async {
   

    dynamic responseJson;
    if (await checkInternetConnection.hasInternetConnection()) {
      final response = await client.delete(
          Uri.parse(
            _baseUrl + url,
          ),
          headers: {
            'Content-Type': 'application/json',
          });
      log(_baseUrl + url);
      log(response.statusCode.toString());
      log(response.body);
      responseJson = returnResponse(response);

      return responseJson;
    } else {
      throw NoInternet('no internet conecction');
    }
  }
}
