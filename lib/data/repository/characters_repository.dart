
import '../model/characters.dart';
import '../model/quote.dart';
import '../web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters.map((character) => Character.fromJson(character)).toList();
  }

  Future<List<Quote>> getRandomQuotes() async {
    final quotes = await charactersWebServices.getRandomQuotes();
    return quotes.map((quote) => Quote.fromJson(quote)).toList();
  }

}
