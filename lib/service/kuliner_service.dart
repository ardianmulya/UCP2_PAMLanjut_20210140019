class KulinerService {

  final String baseUrl = 'http://192.168.224.122/api/';
  final String endpoint = 'kuliner';

    Uri getUri(String path) {
    return Uri.parse("$baseUrl$path");
  }
}