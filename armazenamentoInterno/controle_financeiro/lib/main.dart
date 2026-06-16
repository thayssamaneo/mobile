import 'package:flutter/material.dart';

void main(List<String> args){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: "Controle Financeiro",
    debugShowCheckedModeBanner: false,
    theme:ThemeData(primarySwatch: Colors.blue),
    home: HomeScreen(),
  ))
}
