import 'dart:ffi';

import 'package:http/http.dart' as http;

class BaseService {
  String publicKEY = '5ea3980f323cb76c1187caca74afd66f';
  String privateKEY = 'e4602bd9a88ad1a9b997be30d76a3a61d2af4a3a';
  String param =
      "?ts=1&apikey=5ea3980f323cb76c1187caca74afd66f&hash=efacbc2a5a95762df94f3fdf32518629";

  String baseURLAPI = "http://gateway.marvel.com/v1/public/";

  String formAPI(String endpoint) {
    return "$baseURLAPI$endpoint$param";
  }
}

abstract class MarvelService {
  Future<dynamic> fetchAllMavel();
  Future<http.Response> fetchAllMavelWithId(String id);

  String imageNameForID({String id}) {}
}

class MarvelServiceImpl extends BaseService implements MarvelService {
  @override
  Future<dynamic> fetchAllMavel() {
    return http.get(formAPI("characters"));
  }

  @override
  Future<http.Response> fetchAllMavelWithId(String id) {
    return http.get(formAPI("characters/$id"));
  }

  @override
  String imageNameForID({String id}) {
    return "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg";
  }
}
