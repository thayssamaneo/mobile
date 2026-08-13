import 'package:flutter/material.dart';
import 'cadastar_page.dart';

void main(List<String> args){
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: "Cadastro de produtos",
    debugShowCheckedModeBanner: false,
    home: CadastrarPage(),
  ));
}