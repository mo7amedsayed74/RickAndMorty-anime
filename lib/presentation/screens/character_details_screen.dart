import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/characters_cubit.dart';
import '../../business_logic/cubit/characters_states.dart';
import '../../constants/my_colors.dart';
import '../../data/model/characters.dart';
import '../../data/model/quote.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character selectedCharacter;

  const CharacterDetailsScreen({super.key, required this.selectedCharacter});

  Widget buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      leading: BackButton( /// very important
        onPressed: (){
          BlocProvider.of<CharacterCubit>(context).backToCharacterScreen(context);
        },
      ),
      backgroundColor: MyColors.myGrey,
      pinned: true,
      // it’s effect like ( SafeArea )
      stretch: true,
      expandedHeight: 500,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          selectedCharacter.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(color: Colors.white),
        ),
        background: Hero(
          tag: selectedCharacter.characterId,
          child: Image.network(
            selectedCharacter.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: "$title : ",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: MyColors.myWhite,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              fontSize: 16,
              color: MyColors.myWhite,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return const Divider(
      color: MyColors.myGreen,
      endIndent: 280,
      height: 30,
      thickness: 2,
    );
  }

  Widget buildQuote(CharactersStates state,BuildContext context){
    if(state is QuotesLoaded){
      return displayQuote(state);
    }else{
      return displayCircleProgressIndicator();
    }
  }

  Widget displayQuote(state){
    List<Quote> quotes = (state).quotes;
    int randomIndex = Random().nextInt(20);
    return Center(
      child: DefaultTextStyle(
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 30,
          color: MyColors.myWhite,
          shadows: [
            Shadow(
              blurRadius: 7.0,
              color: MyColors.myGreen,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            FlickerAnimatedText(quotes[randomIndex].content),
          ],
          // onTap: () { print("Tap Event"); },
        ),
      ),
    );
  }

  Widget displayCircleProgressIndicator(){
    return const Center(
      child: CircularProgressIndicator(color: MyColors.myGreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharacterCubit>(context).getQuotes(); // active my bloc
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsetsDirectional.fromSTEB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      characterInfo("name", selectedCharacter.name),
                      buildDivider(),
                      characterInfo("gender", selectedCharacter.gender),
                      buildDivider(),
                      characterInfo(
                          "status", selectedCharacter.statusIfDeadOrAlive),
                      const SizedBox(height: 30),
                      BlocBuilder<CharacterCubit, CharactersStates>(
                        builder: (context, state) => buildQuote(state,context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 500), // for test scrolling
              ],
            ),
          ),
        ],
      ),
    );
  }
}
