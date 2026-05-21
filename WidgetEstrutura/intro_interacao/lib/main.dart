// Uso de elementos de interação (textfield, ElevatedButton, CheckBox, Slider)

import 'package:flutter/material.dart';
import 'pages/contato_page.dart';
import 'pages/form_page.dart';
import 'pages/home_page.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    // sistema de rotas para navegação entre telas
    // home(tela inicial), form(tela de cadastro), contato(formulario de contato)
    routes: {
      "/": (context) => HomePage(),
      "/form": (context) => FormPage(),
      "/contato": (context) => ContatoPage(),
    },
    // direcionar o aplicativo quando iniciar para a home
    initialRoute: "/",
  ));
}

// Página main finalizada