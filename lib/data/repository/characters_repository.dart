import '../model/characters.dart';
import '../web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters.map((character) => Character.fromJson(character)).toList();
  }

  Future<List<String>> getRandomQuotes() async {
    final quotes = await charactersWebServices.getRandomQuotes();
    return List<String>.from(quotes);
    //return quotes.map((quote) => Quote.fromJson(quote)).toList();
  }

}
