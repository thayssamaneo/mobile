import 'package:flutter/material.dart';
import 'package:json_pathprovider_todolist/json_helper.dart';
import 'package:json_pathprovider_todolist/tarefas_page.dart';


class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  // atributos
  Map<String, dynamic> _baseUsuarios = {};
  // controlar um input de texto
  final TextEditingController _nomeUsuario = TextEditingController();

  // métodos
  // initState
  @override
  void initState() {
    super.initState();
    _carregarUsuarios();
  }

  // carregar os usuários
  void _carregarUsuarios() async{
    final dados = await JsonHelper.lerDados();
    setState(() {
      _baseUsuarios = dados;
    });
  }

  // salvar novo usuário
  void _salvarUsuario() async{
    String nome = _nomeUsuario.text.trim();
    if (nome.isNotEmpty && !_baseUsuarios.containsKey(nome)) {
      setState(() {
        _baseUsuarios[nome]=[]; // cria um usuário com uma lista de tarefas vazia
      });
      JsonHelper.salvarDados(_baseUsuarios);
      _nomeUsuario.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // pegar os nomes do json
    List<String> usuarios = _baseUsuarios.keys.toList();

    return Scaffold(
      appBar: AppBar(title: Text("Selecione um usuário"), centerTitle: true,),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                TextField(
                  controller: _nomeUsuario,
                  decoration: InputDecoration(labelText: "Novo usuário"),
                ),
                IconButton(onPressed: _salvarUsuario, icon: Icon(Icons.add, color: Colors.green)),
              ],
            ),
            // expanded com a lista de usuários
            Expanded(child: ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index){
                String usuario = usuarios[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(usuario[0]),), // cria uma bolinha com a primeira letra do nome do usuário
                  title: Text(usuario),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // navegar para a tela de tarefas
                    Navigator.push(context, MaterialPageRoute(builder: (_) => TarefasPage(
                      // vai levar informações do usuário para a página de tarefas
                      nomeUsuario: usuario,
                      db: _baseUsuarios,
                    )));
                  }
                );
              }
            ),)
          ],
        ),
      ),
    );
  }
}