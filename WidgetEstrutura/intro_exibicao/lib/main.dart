// tela para estudo dos widgets de exibição´
// text, image, icon, entre outros

import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    //configurações iniciais do app
    //router --> rotas de navegação
    //home --> pagina inicial
    home: MyApp(),
    // themeApp --> (claro/escuro)
  ));
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  // estrutura da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Elemento principal da tela
      // appBar, drawer, bnBar, body, fabutton, snakebar
      appBar: AppBar(title: Text("Exemplos de Widget de Exibição"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          // adicionar um container
          child: Expanded(
            child: Column(
              children: [
                Text("Explorando o Flutter", textAlign: TextAlign.center, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                Image.network(
                  // link url da imagem
                  "https://rollingstone.com.br/wp-content/uploads/lego-batman-filme-foto-reproducao-warner-bros.jpg",
                  height: 200,
                  fit: BoxFit.cover,
                ),
                // adicionar imagem local
                Image.asset("assets/img/gatinhopanda.png",
                  height: 250,
                  fit: BoxFit.cover),
              ]
            )
          )
        ),
      ),
    );
  }
}