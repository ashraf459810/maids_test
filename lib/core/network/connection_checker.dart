import 'package:internet_connection_checker/internet_connection_checker.dart';



abstract class CheckInternetConnection{
    Future<bool> hasInternetConnection ();
}

class CheckInternetConnectionImp implements CheckInternetConnection {
  @override
  Future<bool> hasInternetConnection() async {
  bool result = await InternetConnectionChecker().hasConnection;
return result;
  
}

}