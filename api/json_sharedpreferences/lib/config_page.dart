import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ConfigPage extends StatefulWidget {
  //atributos
  final bool temaEscuro; // atributo par armazenar o tema escuro
  final String nomeUsuario; // atributo para armazenar o nome do usuário
  final Function(bool, String) onSalvar; // atributo para armazenar a função de salvar as configurações

  // construtor
  const ConfigPage({super.key, required this.temaEscuro, required this.nomeUsuario, required this.onSalvar});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  // atributos
  late bool _temaEscuro; // atributo para armazenar o tema escuro : late => inicializa a variável e depois muda o valor
  late TextEditingController _nomeUsuario; // atributo para armazenar o nome do usuário : late => inicializa a variável e depois muda o valor

  // método para iniciar as variáveis
  initState(){
    super.initState();
    _temaEscuro = widget.temaEscuro; // Atribui o valor do tema escuro passado pelo construtor para a variável local
    _nomeUsuario = TextEditingController(text: widget.nomeUsuario) ; // mesma coisa para o nome de usuário
  }

  // método para salvar as configurações do usuário
  void salvarConfig() async {
    Map<String, dynamic> config = {
      "temaEscuro": _temaEscuro,
      "nome": _nomeUsuario.text.trim()
    };
    // chamar o shared preferences
    // converter o MAP => String/JSON
    // Salvar o valor no sharedpreferences para a chave "config"
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(config);
    prefs.setString("config", jsonString);

    // chamar a atualização
    widget.onSalvar(_temaEscuro, _nomeUsuario.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preferências do Usuário"), centerTitle: true, backgroundColor: Colors.deepOrangeAccent,),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // botão para mudar o tema escuro
            SwitchListTile(
              title: Text("Tema Escuro"),
              value: _temaEscuro,
              onChanged: (bool value){
                setState(() {
                  _temaEscuro = value;
                });
              }
            ),
            TextField(
              controller: _nomeUsuario,
              decoration: InputDecoration(
                labelText: "Nome do Usuário"
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () async {
                salvarConfig();
                // scafoldmessenger
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Preferências salvas")));
              }, 
              child: Text("Salvar preferências"),
            ),
            Divider(),
            Text("Resumo atual:", style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("Tema: ${_temaEscuro? "Escuro" : "Claro"}"),
            Text("Usuário: ${_nomeUsuario.text}"),
          ],
      ),
    ),);
  }
}