import 'package:flutter/material.dart';
import 'package:json_pathprovider_todolist/usuarios_page.dart';

void main(List<String> args){
  // WidgetFlutterBinding => Garante que os bindings do flutter estejam inicializados
  // Inicializa os pacotes nativos do flutter logo no começo da aplicação
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: "Gerenciador de tarefas com JSON",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.lightGreen,
      // tema padrão
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.lightGreenAccent,
        foregroundColor: Colors.white,
        elevation: 2, // destaque 
      )
    ),
    home: UsuariosPage(),
  ));
}