import 'package:flutter/material.dart';
import 'package:rickandmorty/constants/strings.dart';

import '../../constants/my_colors.dart';
import '../../data/model/characters.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, characterDetailsScreen, arguments: character,),
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 6,
            ),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              character.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          child: Hero(
            tag: character.characterId,
            child: Container(
              color: MyColors.myGrey,
              child: character.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                width: double.infinity,
                height: double.infinity,
                placeholder: 'assets/images/loading.gif',
                image: character.image,
                fit: BoxFit.cover,
              )
                  : Image.asset('assets/images/noImage.png'),
            ),
          ),
        ),
      ),
    );
  }
}
