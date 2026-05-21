import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

// Importando as características da página stateful
class MyApp extends StatefulWidget{
  const MyApp({super.key});

  // método para identificar as mudanças de estado e chamar a reconstrução da janela
  @override
  State<MyApp> createState() => _MyAppState();
  // arrow funtion
}

// construção da lógica e da estrutura da janela
class _MyAppState extends State<MyApp>{
  // A classe normal da aplicação
  // Atributos
  int contador = 0;

  // método build da tela (obrigatório)
  @override
  Widget build(BuildContext context){
    return Scaffold(
      // app bar - titulo do app
      appBar: AppBar(title: Text("Aplicativo com StateFul - Contador"), backgroundColor: Colors.blueAccent,),

      // Body
      // container para espaçamento interno
      body: Padding(
        padding: EdgeInsets.all(8), // espaçamento de 8 em todas as bordas
        // container para centralizar os elementos no meio da tela (esquerda e direita)
        child: Center(
          //column => permite adicionar mais de um elemento
          child: Column(
            // centraliza os elementos no eixo principal da column
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("N° de cliques: $contador", style: TextStyle(fontSize: 20),),
              // adicionar botão => toda vez que for pressionado vai criar uma ação (uma mudança de estado)
              ElevatedButton(
                onPressed: (){
              // adicionar setState
                  setState(() {
                    contador++;
                  });
                }, 
                child: Text("Adicionar +1")),
            ],
          ),
        ),
      ), 
    );
  }
}