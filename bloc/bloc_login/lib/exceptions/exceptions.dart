
// ignore_for_file: prefer_typing_uninitialized_variables
// ignore_for_file: annotate_overrides

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "");
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([message]) : super(message,"");
}

class NotFoundException extends CustomException {
  NotFoundException([message]) : super(message, "");
}
