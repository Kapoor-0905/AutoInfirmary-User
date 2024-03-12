class UserNotFoundException implements Exception {
  final String message = 'User not found';
}

class InvalidPasswordException implements Exception {
  final String message = 'Password does not match';
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException(this.message);
}

class HttpException implements Exception {
  final int statusCode;
  final String message;

  HttpException(this.statusCode, this.message);
}
