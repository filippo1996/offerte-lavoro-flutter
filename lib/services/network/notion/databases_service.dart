import 'dart:convert';
import 'dart:io';
import 'package:offertelavoroflutter/errors/network_error.dart';
import 'package:offertelavoroflutter/services/network/notion/dto/databases_response.dart';
import 'package:http/http.dart' as http;

class DatabasesService {

  static Map<String, String> databases = {
    'recruitment': '283d2760f81548f0a7baca4b3e58d7d8',
    'freelance': 'e6a8a6760e3d4430b20a15d16f75f92e',
  };

  final String baseUrl = 'api.notion.com';
  final String notionVersion = '2022-06-28';
  final String authorizationHeader = 'Bearer secret_Azc2DHy4JY0Ved0cD0ObrEFJqIaUqy96CboXgJZp8bZ'; // Da metterlo nel file env
  final String contentType = 'application/json';
  final int pageSize = 4; // (4 for testing) minimum 10 recommended

  const DatabasesService();

  Future<DatabasesResponse> pages(String dbName, { Map<String, dynamic> params = const {} }) async {
    String? databaseId = DatabasesService.databases[dbName];
    if (databaseId == null) {
      throw NetworkError(500, 'database id is null');
    }
    var url = Uri.https(baseUrl, 'v1/databases/$databaseId/query');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: contentType,
      HttpHeaders.authorizationHeader: authorizationHeader,
      'Notion-Version': notionVersion,
    };
    print(params);
    Map<String, dynamic> body = {
      "page_size": pageSize,
      ...params,
    };
    final response = await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode < 200 || response.statusCode > 299) {
      throw NetworkError(response.statusCode, response.reasonPhrase);
    }

    final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return DatabasesResponse.fromJson(decodedResponse);
  }
}