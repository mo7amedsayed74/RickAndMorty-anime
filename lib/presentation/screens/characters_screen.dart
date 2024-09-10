import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../business_logic/cubit/characters_cubit.dart';
import '../../business_logic/cubit/characters_states.dart';
import '../../constants/my_colors.dart';
import '../../data/model/characters.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacters;
  bool isSearching = false;
  final searchTextController = TextEditingController();

  Widget buildSearchField() {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a character...',
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 18,
        ),
        border: InputBorder.none,
      ),
      style: const TextStyle(
        color: MyColors.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchedCharacter) {
        addSearchedForCharacterToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForCharacterToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters.where((character) {
      return character.name.toLowerCase().startsWith(searchedCharacter);
    }).toList();
    setState(() {}); // to update ui with new results
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearch,
          icon: const Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearching() {
    clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    print("characterScreen initState");
    BlocProvider.of<CharacterCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, CharactersStates>(
      builder: (context, state) {
        print("cheeeckkkk state");
        print("state is $state");
        if (state is CharactersLoaded) {
          //allCharacters = state.characters;
          getAllCharacters(state);
          return buildLoadedListWidget();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  void getAllCharacters(CharactersLoaded state){
    if(state.characters.isEmpty){
      // ف محتاج ان اول م النت يشتغل يروح يجيب الكراكترز api لو فتحت الابلكيشن وانا قافل نت معنى كدا انه مجابش الكاركترز من ال
      /// ...الحاله دي بتظهر بس لما افتح الابلكيشن وانا قافل الواي فاي
      /// لاكن لو فتحت الابلكيشن والواي فاي شغال عادي وبعد شويه قفلت الواي فاي و رجعت شغلته مش هيبقا في مشكله عادي لأن الكاركترز جت مره مش محتاج اجيبها تاني
      BlocProvider.of<CharacterCubit>(context).getAllCharacters();
    }
    allCharacters = state.characters;
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: MyColors.myGreen),
    );
  }

  Widget buildLoadedListWidget() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        childAspectRatio: 3 / 2,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchedForCharacters[index],
        );
      },
      itemCount: searchTextController.text.isEmpty
          ? allCharacters.length
          : searchedForCharacters.length,
    );
  }

  Widget buildTitleField() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Can\'t connect .. check internet!',
              style: TextStyle(
                fontSize: 22,
                color: MyColors.myGrey,
              ),
            ),
            Image.asset('assets/images/no_internet.png')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("characterScreen Build");
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      appBar: AppBar(
        backgroundColor: MyColors.myGreen,
        leading: isSearching ? const BackButton(color: MyColors.myGrey) : null,
        title: isSearching ? buildSearchField() : buildTitleField(),
        actions: buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          List<ConnectivityResult> connectivity,
          Widget child,
        ) {
          final bool connected =
              !connectivity.contains(ConnectivityResult.none);
          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('There are no buttons to push :)'),
            Text('Just turn off your internet.'),
          ],
        ),
      ),
    );
  }
}
