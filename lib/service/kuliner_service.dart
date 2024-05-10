import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class KulinerService {
  final String baseUrl = 'http://10.0.2.2/kulinerApi/';
  final String endpoint = 'api.php';

  Uri getUri(String path) {
    return Uri.parse("$baseUrl$path");
  }

  Future<http.Response> addResto(Map<String, String> data, File? file) async {
    var request = http.MultipartRequest(
      'POST',
      getUri(endpoint),
    )
      ..fields.addAll(data)
      ..headers['Content-Type'] = 'application/json';

    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('gambar', file.path));
    } else {
      request.files.add(http.MultipartFile.fromString('gambar', ''));
    }
    return await http.Response.fromStream(await request.send());
  }

  Future<List<dynamic>> fetchResto() async {
    var response = await http.get(
        getUri(
          endpoint,
        ),
        headers: {
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      final List<dynamic> decodedResponse = json.decode(response.body);
      return decodedResponse;
    } else {
      throw Exception('Failed to load resto: ${response.reasonPhrase}');
    }
  }

  Future<http.Response> editResto(
      Map<String, String> data, File? file, String id) async {
    var request = http.MultipartRequest(
      'PUT',
      getUri('$endpoint/$id'),
    )
      ..fields.addAll(data)
      ..headers['Content-Type'] = 'multipart/form-data';

    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('gambar', file.path));
    }

    return await http.Response.fromStream(await request.send());
  }

  Future<http.Response> deleteResto(String id) async {
    return await http.delete(getUri('$endpoint/$id'));
  }
}
