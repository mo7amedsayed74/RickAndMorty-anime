import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/app_router.dart';

import 'business_logic/bloc_observer.dart';
import 'business_logic/cubit/characters_cubit.dart';
import 'data/repository/characters_repository.dart';
import 'data/web_services/characters_web_services.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  HttpOverrides.global = MyHttpOverrides();
  runApp(BreakingBadApp(appRouter: AppRouter()));
}

/// solve
// DioException [unknown]: null
// HandshakeException: Handshake error in client
// CERTIFICATE_VERIFY_FAILED: certificate has expired(handshake.cc:393))

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class BreakingBadApp extends StatelessWidget {
  const BreakingBadApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider( /// solve (onClose -- CharacterCubit) problem
      create: (BuildContext context) => CharacterCubit(CharactersRepository(CharactersWebServices()))..getAllCharacters(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
