import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Exemplo2Page extends StatefulWidget {
  final bool initialDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const Exemplo2Page({
    super.key,
    required this.initialDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<Exemplo2Page> createState() => _Exemplo2PageState();
}

class _Exemplo2PageState extends State<Exemplo2Page> {
  late final SharedPreferences _prefs;
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _darkMode = widget.initialDarkMode;
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _prefs = prefs;
    setState(() {
      _darkMode = _prefs.getBool('darkMode') ?? widget.initialDarkMode;
    });
  }

  Future<void> _savePreferences(bool value) async {
    setState(() {
      _darkMode = value;
    });
    await _prefs.setBool('darkMode', _darkMode);
    widget.onThemeChanged(_darkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modo escuro com Shared Preferences', style: TextStyle(color: Colors.white),), backgroundColor: Colors.deepPurpleAccent, centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tema Atual: ${_darkMode ? 'Escuro' : 'Claro'}'),
            Switch(value: _darkMode, onChanged: _savePreferences),
          ],
        ),
      ),
    );
  }
}
