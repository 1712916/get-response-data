sealed class ApiResponse {}

class ErrorApiResponse extends ApiResponse {
  final int statusCode;
  final String message;

  ErrorApiResponse({
    required this.statusCode,
    required this.message,
  });
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
//
// void main() async {
//   final response = await OpenWeatherApisClient().get('/find', {
//     'q': 'ho chi minh',
//     'appid': '439d4b804bc8187953eb36d2a8c26a02',
//   });
//
//   switch (response) {
//     case ErrorDataResponse():
//       print('ErrorDataResponse');
//       return;
//     case TimeOutDataResponse():
//       print('TimeOutDataResponse');
//       return;
//     case SuccessDataResponse():
//       print('SuccessDataResponse: ${response.data.runtimeType}');
//       print('SuccessDataResponse: ${response.data}');
//       return;
//   }
// }
