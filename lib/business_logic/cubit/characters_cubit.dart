import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/characters.dart';
import '../../data/repository/characters_repository.dart';
import 'characters_states.dart';

class CharacterCubit extends Cubit<CharactersStates> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharacterCubit(this.charactersRepository) : super(InitialState());

  void getAllCharacters() {
    print("getAllCharacters cubit");
    charactersRepository.getAllCharacters().then((characters) {
      this.characters = characters;
      emit(CharactersLoaded(characters));
    });
  }

  void getQuotes() {
    charactersRepository.getRandomQuotes().then((quotes) {
      emit(QuotesLoaded(quotes));
    });
  }

  void backToCharacterScreen(context){
    print("backToCharacterScreen");
    emit(CharactersLoaded(characters)); /// very important to emit CharactersLoaded again
    Navigator.pop(context);
  }

}
