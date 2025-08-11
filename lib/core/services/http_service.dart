import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpService {
  final http.Client client;
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  HttpService({http.Client? client}) : client = client ?? http.Client();

  Future<http.Response> get(String url) async {
    return await client.get(Uri.parse('$baseUrl$url'));
  }

  // se pueden crear el post y el put
}
