import 'dart:convert';

import 'package:marvel/models/heroes.dart';
import 'package:marvel/services/marvel_service.dart';

enum MarvelListState { feededDatasource, error, loading }

class HeroesListViewModel {
  List<AllHeroesReponse> dataSource = [];
  String navigationTitle = "HEROES";
  MarvelListState state;

  final MarvelService service;
  Function didUpdate;
  HeroesListViewModel({this.didUpdate, this.service});

  dataSourceHeroes(MarvelService marvelService) {
    marvelService.fetchAllMavel().then((response) {
      var json = jsonDecode(response.body);
      List<AllHeroesReponse> heroesList = [];
      var list = json["data"]["results"];
      if (list != null) {
        for (var heroesJson in list) {
          var heroesResponse = AllHeroesReponse.fromMappedJson(heroesJson);
          heroesList.add(heroesResponse);
        }
        dataSource = heroesList;
        didUpdate();
      }
    });
  }

  Future feedDataSource() async {
    state = MarvelListState.feededDatasource;
    _updateIfNeeded();

    return service.fetchAllMavel().then((json) {
      List<AllHeroesReponse> heroesList = [];
      // var list = json["results"];
      var list = null;

      if (list != null) {
        for (var HeroesJson in list) {
          var heroesResponse = AllHeroesReponse.fromMappedJson(HeroesJson);

          if (HeroesJson["url"] != null) {
            var id = extractID(HeroesJson["url"]);
            heroesResponse.name = service.imageNameForID(id: id);
          }

          heroesList.add(heroesResponse);
        }

        dataSource = heroesList;
        state = MarvelListState.feededDatasource;
        _updateIfNeeded();
      }
    }).catchError((error) {
      state = MarvelListState.error;
      _updateIfNeeded();
      print(error);
    });
  }

  String toUpperCase(String value) {
    if (value == null) {
      return "null";
    }
    return value.toUpperCase();
  }

  String extractID(String url) {
    if (!url.contains("/")) {
      return "error";
    }

    var split = url.toString().split("/");
    split.removeLast();
    return split.last;
  }

  void _updateIfNeeded() {
    if (didUpdate != null) {
      didUpdate();
    }
  }
}
