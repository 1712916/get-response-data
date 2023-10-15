import 'package:get_response_data/data_response.dart';

abstract class ApiClient {
  Future<ApiResponse> get(String path, Map<String, dynamic> queryParameters);

  ///post,delete or something else should add later
}
