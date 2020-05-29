import 'package:http/http.dart' as http;
import 'package:marvel/services/marvel_service.dart';

enum MockedState { success, error }

class MockedHeroesService implements MarvelService {
  MockedState state;

  MockedHeroesService({this.state = MockedState.success});

  Future _fetchAllHeroesWithSuccess() {
    Future<dynamic> future = Future<dynamic>(() {
      var list = [
        {"name": "Abyss", "url": "Abyss test"},
        {"name": "Abyss", "url": "Abyss test"},
        {"name": "Abyss", "url": "Abyss test"},
        {"name": "Abyss", "url": "Abyss test"},
        {"name": "Abyss", "url": "Abyss test"},
      ];

      Map<String, dynamic> json = {"results": list};
      return json;
    });

    return future;
  }

  _fetchAllHeroesWithError() {
    return Future.error("404");
  }

  @override
  Future<dynamic> fetchAllMavel() {
    switch (state) {
      case MockedState.success:
        return _fetchAllHeroesWithSuccess();
        break;
      case MockedState.error:
        return _fetchAllHeroesWithError();
        break;
    }
    return _fetchAllHeroesWithError();
  }

  @override
  Future<http.Response> fetchAllMavelWithId(String id) {
    throw UnimplementedError();
  }

  @override
  String imageNameForID({String id}) {
    return id;
  }

//=============mocked heroes detail==========

}
