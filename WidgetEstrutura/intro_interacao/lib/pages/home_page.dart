// tela inicial
// vai ter botões de navegação para outras telas

import 'package:flutter/material.dart';
import 'package:intro_interacao/widgets/bnb.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🍃 Meu aplicativo interativo 🍃"),backgroundColor: Colors.indigo,),
      body: Padding(
        padding:EdgeInsets.all(8),
        child: Center(
          // centraliza elementos na horizontal
          child: Column(
            // alinhamento no eixo vertical
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo do aplicativo
              Image.network("https://i.pinimg.com/originals/3e/50/c8/3e50c82d8802a640d1e68cf7a7427d74.gif",
              width: 150,
              height: 150,),
              //bloco de espaçamento
              SizedBox(height: 20,),
              // botões de navegação
              ElevatedButton(onPressed: ()=> Navigator.pushNamed(context, "/form"), child: Text("Responder formulário")),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: ()=>Navigator.pushNamed(context, "/contato"), child: Text("Entre em contato")),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Bnb(context),
    );
  }
}