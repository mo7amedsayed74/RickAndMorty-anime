import 'package:dio/dio.dart';

import '../../constants/strings.dart';

class CharactersWebServices {
  late Dio characterDio;
  late Dio quoteDio;

  CharactersWebServices() {
    BaseOptions options1 = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );

    BaseOptions options2 = BaseOptions(
      baseUrl: quoteBaseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );

    characterDio = Dio(options1);
    quoteDio = Dio(options2);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try{
      Response response = await characterDio.get('character');
      return response.data['results'];
    }catch(e){
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getRandomQuotes() async {
    try{
      Response response = await quoteDio.get('quotes');
      return response.data['results'];
    }catch(e){
      print(e.toString());
      return [];
    }
  }

}
