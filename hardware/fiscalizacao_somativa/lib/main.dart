import 'package:flutter/material.dart';
import 'controllers/registro_controller.dart';
import 'views/lista_registros_view.dart';

// Ponto de entrada da aplicação SENAI CheckIn.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SenaiCheckInApp());
}

class SenaiCheckInApp extends StatelessWidget {
  const SenaiCheckInApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RegistroController();

    return MaterialApp(
      title: 'SENAI CheckIn',
      debugShowCheckedModeBanner: false,
      theme: _construirTemaAplicacao(),
      home: ListaRegistrosView(controller: controller),
    );
  }

  ThemeData _construirTemaAplicacao() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFC4161C),
        primary: const Color(0xFFC4161C),
        secondary: const Color(0xFFE53935),
      ),
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
