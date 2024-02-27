import 'package:buscador_gif_aula/repositories/repositorio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buscador_gif_aula/repositories/repositorio.dart';
import '';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Repositorio rep = Repositorio();

  late Future<Map> gifs;

  TextEditingController controlerBusca = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Image.asset("assets/images/logo.png"),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Digite sua pesquisa"),
            controller: controlerBusca,
            onSubmitted: (text) {
              gifs = rep.buscarDados(text);
              print(gifs);
            },
          ),
          Expanded(
            child: GridView.builder(
                padding: EdgeInsets.all(10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0),
                itemCount: 10,
                itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Icon(Icons.person, size: 200.0,),
                      onTap: (){},
                    );
                }),

          )
        ],
      ),
    );
  }
}
