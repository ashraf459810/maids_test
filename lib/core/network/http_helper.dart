import 'package:http/http.dart'as http;
abstract class HttpHelper {
  Future<dynamic> getRequest(String url);
  Future<dynamic> postRequest(String url , body);
  Future<dynamic> putRequest (String url , body);
  Future<dynamic> deleteRequest (String url);
  dynamic returnResponse(http.Response response);
}