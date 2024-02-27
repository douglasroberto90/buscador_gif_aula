import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Repositorio{

  //api.giphy.com/v1/gifs/search
  //api_key=***
  //q=busca
  //limit=20
  //rating=g

  Future<Map> buscarDados(String texto) async{
    await dotenv.load(fileName: "keys.env");
    var api_key= dotenv.env["API_KEY"];
    //print(api_key);
    var url = Uri.https("api.giphy.com","/v1/gifs/search",
        {"api_key":api_key,"q":"$texto",
        "limit":"20","rating":"g"});
    //print(url);
    var resultado = await http.get(url);
    //print(json.decode(resultado.body));
    return json.decode(resultado.body);
  }

  //api.giphy.com/v1/gifs/trending
  //api_key:***
  //limit: integer
  // rating: string

  //flutter dot_env

  Future<Map> buscarTrending() async{
    await dotenv.load(fileName: "keys.env");
    var api_key= dotenv.env["API_KEY"];
    var url = Uri.https("api.giphy.com","/v1/gifs/trending",
        {"api_key":api_key,
          "limit":"20","rating":"g"});
    //print(url);
    var resultado = await http.get(url);
    //print(json.decode(resultado.body));
    return json.decode(resultado.body);
  }
}