import 'dart:io';

import 'package:http/http.dart' as http;

class KulinerService {

  final String baseUrl = 'http://192.168.224.122/api/';
  final String endpoint = 'kuliner';

    Uri getUri(String path) {
    return Uri.parse("$baseUrl$path");
  }
  Future<http.Response> addKuliner(Map<String, String> data, File? file) async {
    var request = http.MultipartRequest(
      'POST',
      getUri(endpoint),
    )
      ..fields.addAll(data)
      ..headers['Content-Type'] = 'application/json';

    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('foto', file.path));
    } else {
      request.files.add(http.MultipartFile.fromString('foto', ''));
    }

    return await http.Response.fromStream(await request.send());
  }
}