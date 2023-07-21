part of'./../../../features.dart';

class WrongCredentials implements Exception {}
class WrongToken implements Exception {}

class CustomError implements Exception {
  final String message;

  // final int errorCode;
  CustomError(this.message);
}
