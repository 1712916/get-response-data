sealed class ApiResponse {}

class ErrorApiResponse extends ApiResponse {
  final int statusCode;
  final String message;

  ErrorApiResponse({
    required this.statusCode,
    required this.message,
  });

  @override
  String toString() {
    return 'statusCode: $statusCode' ' message: $message';
  }
}

class TimeOutApiResponse extends ApiResponse {}

class SuccessApiResponse extends ApiResponse {
  final int statusCode;
  final String message;
  final dynamic data;

  SuccessApiResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });
}

class UnknownResponse extends ApiResponse {}
