import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Exemplo3Page extends StatefulWidget {
  const Exemplo3Page({super.key});

  @override
  State<Exemplo3Page> createState() => _Exemplo3PageState();
}

class _Exemplo3PageState extends State<Exemplo3Page> {
  List<String> _tarefas = []; // armazenar as tarefas
  final TextEditingController _inputTarefa = TextEditingController(); // controlar o input de tarefas
  
  late SharedPreferences _prefs;
  String nome = "";

  // métodos
  @override
  void initState(){
    super.initState();
    _loadTarefas();
  }

  void _loadTarefas() async{
    _prefs = await SharedPreferences.getInstance();
    nome = _prefs.getString("nome") ?? ""; // verificação de nulidade

    setState(() {
      _tarefas = _prefs.getStringList("tarefas+$nome") ?? [];
    });
  }

  // salvar dados no shared
  void _savePreferences() async{
    _prefs = await SharedPreferences.getInstance();
    nome = _prefs.getString("nome") ?? "";
    // salvar as preferencias
    await _prefs.setStringList("tarefas+$nome", _tarefas);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Tarefas do(a) $nome", style: TextStyle(color: Colors.white),), centerTitle: true, backgroundColor: Colors.deepPurpleAccent,),
      body: Padding(padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: _inputTarefa,
              decoration: InputDecoration(labelText: "Digite a tarefa"),
            ),
            ElevatedButton(onPressed: (){
              setState(() {
                _tarefas.add(_inputTarefa.text.trim());
                _savePreferences();
              });
            },
            child: Text("Adicionar")),
            SizedBox(height: 20,),
            Expanded(child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tarefas[index]),
                  onLongPress: () {
                    setState(() {
                      _tarefas.removeAt(index); // remove a tarefa
                      _savePreferences(); // salva no shared
                    });
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}