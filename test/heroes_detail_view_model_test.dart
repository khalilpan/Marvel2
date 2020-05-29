import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/features/heroes_detail/HeroesDetailViewModel.dart';
import 'package:marvel/services/marvel_service.dart';

void main() {
  HeroesDetailViewModel viewModel;
  MarvelService service;

  setUpAll(() {
    service = MarvelServiceImpl();
    viewModel = HeroesDetailViewModel();
  });

  tearDownAll(() {
    service = null;
    viewModel = null;
  });


test('Upper case emtpy string', () {
    String lowercasedString = "";
    expect(viewModel.toUpperCase(lowercasedString), "");
  });

  test('Upper case lowercased string', () {
    String lowercasedString = "lowercased";
    expect(viewModel.toUpperCase(lowercasedString), "LOWERCASED");
  });

  test('Upper case uppercased string', () {
    String uppercasedString = "UPPERCASED";
    expect(viewModel.toUpperCase(uppercasedString), uppercasedString);
  });

  test('Upper case null string', () {
    String nullString;
    expect(viewModel.toUpperCase(nullString), "null");
  });

}
