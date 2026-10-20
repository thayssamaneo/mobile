import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lista_tarefas_firebase/screen/auth_screen.dart';

void main(List<String> args) async{
  // Carregamento dos Widgets ao inicializar
  WidgetsFlutterBinding.ensureInitialized();
  // conectar a aplicação ao firebase
  await Firebase.initializeApp();
  runApp(MaterialApp(home: AuthScreen(), debugShowCheckedModeBanner: false,));

}