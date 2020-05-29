import 'dart:convert';

import 'package:marvel/models/heroes.dart';
import 'package:marvel/services/marvel_service.dart';

class HeroesDetailViewModel {
  Function didUpdate;

  AllHeroesReponse allHeroesReponse;

  HeroesDetailViewModel({this.didUpdate});

  fetchHerosWithId(MarvelService marvelService) {
    marvelService.fetchAllMavelWithId("1009144").then((response) {
      var json = jsonDecode(response.body);
      var result = json['data']['results'];
      AllHeroesReponse heroesList;
      for (var heroesJson in result) {
        heroesList = AllHeroesReponse.fromMappedJson(heroesJson);
      }
      allHeroesReponse = heroesList;
      didUpdate();
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
