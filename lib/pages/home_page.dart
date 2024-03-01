import 'package:buscador_gif_aula/repositories/repositorio.dart';
import 'package:flutter/material.dart';
import 'package:buscador_gif_aula/pages/gif_page.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

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
  void initState() {
    super.initState();
    gifs = rep.buscarTrending();
  }

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
              setState(() {
                gifs = rep.buscarDados(text);
              });
            },
          ),
          Expanded(
            child: FutureBuilder(
                future: gifs,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                        width: 200.0,
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.black),
                          strokeWidth: 5.0,
                        ),
                      );
                    default:
                      if (snapshot.hasError)
                        //Retorna um container vazio
                        return Container();
                      else
                        //Senão cria a grid dos gifs atraves desse método abaixo
                        return _criarGridGifs(context, snapshot);
                  }
                }),
          )
        ],
      ),
    );
  }
}

Widget _criarGridGifs(BuildContext context, AsyncSnapshot snapshot) {
  return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: snapshot.data["data"][index]["images"]["fixed_height"]
              ["url"]),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) {
                      return GifPage(snapshot.data["data"][index]);
                    }
                )
            );
          },
          onLongPress: (){
            Share.share(snapshot.data["data"][index]["images"]["fixed_height"]
            ["url"],);
          },
        );
      });
}

/*


          Navegação
          onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GifPage(snapshot.data["data"][index])));
                            }

 */