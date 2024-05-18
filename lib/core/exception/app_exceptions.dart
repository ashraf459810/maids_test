class AppException implements Exception {
 final String message;
 final String prefix;
  
AppException(this.message, this.prefix);
  

}

class FetchDataException extends AppException {
  FetchDataException([ message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([ message]) : super(message, "Invalid Input: ");
}

class NoInternet extends AppException {
  NoInternet([ message]) : super(message, "Check your Internet");
}

class InternalServerError extends AppException {
  InternalServerError([ message]) : super(message, "Internal Server Error");
}