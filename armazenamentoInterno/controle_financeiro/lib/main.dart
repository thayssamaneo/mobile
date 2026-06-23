import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(MaterialApp(
    title: "Controle Financeiro",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: const Color(0xFF415A77),
      useMaterial3: true,
    ),
    home: const HomeScreen(),
  ));
}