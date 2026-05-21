// página de exibição das notas

import 'package:exemplo_sqlite/nota_dbhelper.dart';
import 'package:exemplo_sqlite/nota_model.dart';
import 'package:flutter/material.dart';

class NotaPage extends StatefulWidget {
  const NotaPage({super.key});

  @override
  State<NotaPage> createState() => _NotaPageState();
}

class _NotaPageState extends State<NotaPage> {
  // instanciar o DBHelper
  final NotaDbhelper _dbhelper = NotaDbhelper();
  // toda vez que precisar de conexão com o banco, usar o dbhelper

  // atibutos
  List<Nota> _notas = [];
  bool _isLoading = true; // usar como indicador de conexão com o DB

  @override
  void initState() {
    super.initState();
    _carregarNotas();
  }

// carrega as notas para o vetor
  void _carregarNotas() async{
    setState(() {
      _isLoading = true;
    });
    // chamar o método read
    _notas = [];
    _notas = await _dbhelper.getNotas(); // carregar as notas para a lista
    setState(() {
      _isLoading = false;
    });
  }

  // criar nota no db
  void _addNota() async{
    Nota novaNota = Nota(titulo: "Nota ${DateTime.now()}", conteudo: "Conteúdo da nota");
    _dbhelper.create(novaNota);
    _carregarNotas();
  }

  void _deleteNota(int id) async{
    _dbhelper.deleteNota(id);
    _carregarNotas();
  }

  void _updateNota(Nota nota) async{
    Nota notaAtualizada = Nota(id: nota.id, titulo: "${nota.titulo} (editado)", conteudo: nota.conteudo);
    _updateNota(notaAtualizada);

    // criar um alertDialog para atualizar a nota
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Atualizar Nota"),
        content: TextField(
          controller: TextEditingController(text: nota.conteudo),
          onChanged: (value){
            notaAtualizada = Nota(id: nota.id, titulo: nota.titulo, conteudo: value);
          },
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
            _dbhelper.updateNota(notaAtualizada);
            _carregarNotas();
          }, child: Text("Atualizar"))
        ],
      );
    });
  }
  
  // criar o build na tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Minhas notas", style: TextStyle(color: Colors.white),), centerTitle: true, backgroundColor: Colors.green[900],),
      body: _isLoading 
      ? Center(child: CircularProgressIndicator(),)
      : ListView.builder(
        itemCount: _notas.length,
        itemBuilder: (context, index){
          final nota = _notas[index];
          return ListTile(
            title: Text(nota.titulo),
            subtitle: Text(nota.conteudo),
            trailing: IconButton(onPressed: () => _deleteNota(nota.id!), icon: Icon(Icons.delete, color: Colors.red,)),
            onLongPress: () => _updateNota(nota),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNota,
        tooltip: "Adicionar nota",
        child: Icon(Icons.add, color: Colors.green[900],),
      ),
    );
  }
}