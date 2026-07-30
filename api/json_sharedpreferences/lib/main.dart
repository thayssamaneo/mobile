import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_sharedpreferences/config_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Atributos
  bool temaEscuro = false;
  String nomeUsuario = "";

  // Método para carregar informações antes mesmo do build da tela
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarPreferencias();
  }

  // Método para conectar com o Shared Preferences
  void carregarPreferencias() async {
    // Conexão com o SharedPreferences (pub add para adicionar o SharedPrefences)
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString("config");
    // Se jsonString não for nula
    if (jsonString != null) {
      // Converter o texto/Json em Map/Dart
      Map<String, dynamic> config = json.decode(jsonString);
      // Chama a mudança de estado
      setState(() {
        // Atribuit as variáveis os valores armazenados
        temaEscuro =
            config["temaEscuro"] ??
            false; //Se a variavel tema escuro for nula atribua o valor false
        nomeUsuario = config["nome"] ?? ""; // Se variavel nome = null => ""
      });
    }
  }

  // Método Build

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App de Configuração",
      theme: temaEscuro ? ThemeData.dark() : ThemeData.light(),
      home: ConfigPage(
        temaEscuro: temaEscuro,
        nomeUsuario: nomeUsuario,
        onSalvar: (bool tema, String nome){
          setState(() {
            temaEscuro = tema;
            nomeUsuario = nome;
          });
        },
      ),
    );
  }
}
