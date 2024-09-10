import '../../data/model/characters.dart';
import '../../data/model/quote.dart';

abstract class CharactersStates{}

class InitialState extends CharactersStates{}

class CharactersLoaded extends CharactersStates{
  final List<Character> characters;

  CharactersLoaded(this.characters);
}

class QuotesLoaded extends CharactersStates{
  final List<Quote> quotes;

  QuotesLoaded(this.quotes);
}
