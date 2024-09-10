import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/app_router.dart';

import 'business_logic/bloc_observer.dart';
import 'business_logic/cubit/characters_cubit.dart';
import 'data/repository/characters_repository.dart';
import 'data/web_services/characters_web_services.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(BreakingBadApp(appRouter: AppRouter()));
}

class BreakingBadApp extends StatelessWidget {
  const BreakingBadApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider( /// solve (onClose -- CharacterCubit) problem
      create: (BuildContext context) => CharacterCubit(CharactersRepository(CharactersWebServices())),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
