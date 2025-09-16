import '../../data/model/characters.dart';

abstract class CharactersStates{}

class InitialState extends CharactersStates{}

class CharactersLoaded extends CharactersStates{
  final List<Character> characters;

  CharactersLoaded(this.characters);
}

class QuotesLoaded extends CharactersStates{
  final List<String> quotes;

  QuotesLoaded(this.quotes);
}
