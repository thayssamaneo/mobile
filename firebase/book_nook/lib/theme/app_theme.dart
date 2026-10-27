import 'package:flutter/material.dart';

// Definição de tema e paleta visual para o Book Nook
class AppTheme {
  // Paleta de cores inspirada em bibliotecas clássicas e estética editorial
  static const Color primario = Color(0xFF6A381F);
  static const Color secundario = Color(0xFFD4A373);
  static const Color fundo = Color(0xFFF9F7F2);
  static const Color superficie = Colors.white;
  static const Color textoPrincipal = Color(0xFF2B2118);
  static const Color textoSecundario = Color(0xFF7A6E65);
  static const Color destaque = Color(0xFF2E6F40);

  // Gera o tema claro da aplicação
  static ThemeData obterTemaClaro() {
    final esquemaCores = _criarEsquemaCores();
    return ThemeData(
      useMaterial3: true,
      colorScheme: esquemaCores,
      scaffoldBackgroundColor: fundo,
      appBarTheme: _criarAppBarTheme(esquemaCores),
      cardTheme: _criarCardTheme(),
      elevatedButtonTheme: _criarElevatedButtonTheme(),
      inputDecorationTheme: _criarInputDecorationTheme(),
    );
  }

  // Cria o esquema de cores Material 3
  static ColorScheme _criarEsquemaCores() {
    return ColorScheme.fromSeed(
      seedColor: primario,
      primary: primario,
      secondary: secundario,
      surface: superficie,
      brightness: Brightness.light,
    );
  }

  // Cria o tema da barra superior
  static AppBarTheme _criarAppBarTheme(ColorScheme cores) {
    return AppBarTheme(
      backgroundColor: fundo,
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 1,
      titleTextStyle: const TextStyle(
        color: textoPrincipal,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: cores.primary),
    );
  }

  // Cria a estilização padrão dos cartões
  static CardThemeData _criarCardTheme() {
    return CardThemeData(
      color: superficie,
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  // Estilização dos botões principais
  static ElevatedButtonThemeData _criarElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primario,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Estilização padrão dos campos de entrada de texto
  static InputDecorationTheme _criarInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2DDD5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2DDD5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primario, width: 1.5),
      ),
    );
  }
}
