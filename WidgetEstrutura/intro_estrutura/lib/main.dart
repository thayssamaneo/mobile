// Criar o void main
// responsável por rodar o elemento principal da aplicação

import 'package:flutter/material.dart';

void main(){
  // runApp --> chama o elemento com o materialApp
  runApp(MainApp());
}

// Criar a classe mainApp
class MainApp extends StatelessWidget{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // montar a estrutura do MaterialApp
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Tela de Login"),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Elementos de input de textos
              Text("Email"),
              TextField(textAlign: TextAlign.center,),
              Text("Senha"),
              TextField(textAlign: TextAlign.center,obscureText: true,),
              TextButton(onPressed: (){}, child: Text("Enviar"))
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: // permite mais de um item, abre colchetes
            [
              BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: "back"),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.arrow_forward), label: "forward"),            
            ]
        ),
      ),
    );
  }
}