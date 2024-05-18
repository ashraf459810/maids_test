import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';


import 'package:http/http.dart';
import 'package:maids_test/core/const/const.dart';
import 'package:maids_test/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exception/app_exceptions.dart';
import 'http_helper.dart';

class HttpHelperImp implements HttpHelper {
  final Client client;
  final String _baseUrl = "https://dummyjson.com";

  HttpHelperImp(this.client);

  @override
  Future getRequest(String url) async {
    dynamic responseJson;

    var connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
        break;
      case ConnectivityResult.mobile:
        break;
      case ConnectivityResult.none:
        throw NoInternet("No Internet");
      case ConnectivityResult.bluetooth:
        break;
      case ConnectivityResult.ethernet:
        break;
      case ConnectivityResult.vpn:
        break;
      case ConnectivityResult.other:
        break;
    }

    final response = await client.get(Uri.parse(_baseUrl + url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${sl<SharedPreferences>().getString(User.token)??''}', // Include the authorization token
    });

    log("here from http $url");
    log(response.body);
    log(response.statusCode.toString());
    responseJson = returnResponse(response);

    return responseJson;
  }

  @override
  Future postRequest(String url, [body]) async {
    log(body.toString());
    log(_baseUrl + url);

    dynamic responseJson;
    var connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
        break;
      case ConnectivityResult.mobile:
        break;
      case ConnectivityResult.none:
        throw NoInternet("No Internet");
      case ConnectivityResult.bluetooth:
        break;
      case ConnectivityResult.ethernet:
        break;
      case ConnectivityResult.vpn:
        break;
      case ConnectivityResult.other:
        break;
    }

    final response = await client
        .post(Uri.parse(_baseUrl + url), body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
            'Authorization': 'Bearer ${sl<SharedPreferences>().getString(User.token)??''}', // Include the authorization token
    });
    log(response.body);
    log("here from http $url");
    log(response.body);
    log(response.statusCode.toString());

    responseJson = returnResponse(response);

    return responseJson;
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
  Future putRequest(String url ,[body]) async {
    log(_baseUrl + url);

    dynamic responseJson;
    var connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
        break;
      case ConnectivityResult.mobile:
        break;
      case ConnectivityResult.none:
        throw NoInternet("No Internet");
      case ConnectivityResult.bluetooth:
        break;
      case ConnectivityResult.ethernet:
        break;
      case ConnectivityResult.vpn:
        break;
      case ConnectivityResult.other:
        break;
    }

    final response = await client.put(
        Uri.parse(
          _baseUrl + url,
        ),
        headers: {
          'Content-Type': 'application/json',
        });
    log(response.body);
    log("here from http $url");
    log(response.body);
    log(response.statusCode.toString());
    responseJson = returnResponse(response);

    return responseJson;
  }




    @override
  Future deleteRequest(String url) async {
    log(_baseUrl + url);

    dynamic responseJson;
    var connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
        break;
      case ConnectivityResult.mobile:
        break;
      case ConnectivityResult.none:
        throw NoInternet("No Internet");
      case ConnectivityResult.bluetooth:
        break;
      case ConnectivityResult.ethernet:
        break;
      case ConnectivityResult.vpn:
        break;
      case ConnectivityResult.other:
        break;
    }

    final response = await client.delete(
        Uri.parse(
          _baseUrl + url,
        ),
        headers: {
          'Content-Type': 'application/json',
        });
    log(response.body);
    log("here from http $url");
    log(response.body);
    log(response.statusCode.toString());
    responseJson = returnResponse(response);

    return responseJson;
  }
}
