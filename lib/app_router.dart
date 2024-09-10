import 'package:flutter/material.dart';
import 'package:rickandmorty/constants/strings.dart';
import 'package:rickandmorty/data/model/characters.dart';
import 'package:rickandmorty/presentation/screens/character_details_screen.dart';
import 'package:rickandmorty/presentation/screens/characters_screen.dart';

class AppRouter {
  // late CharactersRepository charactersRepository;
  // late CharacterCubit characterCubit;

  // AppRouter() {
  //   charactersRepository = CharactersRepository(CharactersWebServices());
  //   characterCubit = CharacterCubit(charactersRepository);
  // }


  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => const CharactersScreen(),
        );

      case characterDetailsScreen:
        final Character character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => CharacterDetailsScreen(selectedCharacter: character),
        );
    }
    /// switch end

    return null;
  }
}
