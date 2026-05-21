// Situação de aprendizagem 02 - Aplicativo To-do list

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TodoListView(),
  ));
}

// Criar a classe da janela Stateful
// 1° classe: identifica as mudanças de estado e chama o rebuild da tela
class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  // chama o rebuild
  @override
  State<TodoListView> createState() => _TodoListViewState();
}

// 2° classe: fica a lógica da tela, atributos / métodos
class _TodoListViewState extends State<TodoListView> {
  // atributos
  // obj para controlar os dados do input
  // --> final = imutável, porém somente depois de alterado uma vez, permite uma única mudança de valor
  // _ --> quando usado transforma a variável em private
  final TextEditingController _tarefasController = TextEditingController();
  final List<Map<String, dynamic>> _tarefas = []; // map = lista não ordenada | lista de coleções [{},{}], cada coleção é um map (key, value)

  // métodos

  // build --> lógica por trás da construção da janela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de tarefas"), backgroundColor: Colors.blueAccent, centerTitle: true,),
      body: Padding(padding: EdgeInsets.all(8),
        child: Column(
          children: [
          // adcionar + de 1 elemento
          // input da tarefa
            TextField(
              // controle para o texto inserido
              controller: _tarefasController, // passar o valor do texto para o controller
              decoration: InputDecoration(
                labelText: "Digite uma tarefa..." // placeholder do input
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: _adicionarTarefa, // método para adicionar tarefa
              child: Text("Adicionar Tarefa")),
            // listar as tarefas da lista
            // scroll de parte da tela
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length, // contagem de quantas tarefas vão ter
                itemBuilder: (context, index) =>
                  // para cada elemento faça foreach
                  ListTile(
                    title: Text(_tarefas[index]["titulo"], style: TextStyle(
                      // operador ternário
                      decoration: _tarefas[index]["concluida"] ? TextDecoration.lineThrough : null),),
                    // adicionar um checkbox antes do texto
                    leading: Checkbox(
                      value: _tarefas[index]["concluida"], 
                      onChanged: (bool? valor)=> setState(() {
                        // rebuild da janela
                        _tarefas[index]["concluida"] = valor!; // inverte o valor da booleana
                      })),
                      // adicionar icone para deletar tarefa
                      trailing: IconButton(
                        onPressed: () => _deletarTarefa(index), 
                        icon: Icon(Icons.delete)
                      ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// método para adicionar tarefa
  void _adicionarTarefa() {
    if (_tarefasController.text.trim().isNotEmpty){
      // se tarefa não estiver vazia
      // adiciona a tarefa na lista
      // mudar o estado da janela
      setState(() {
        // envia um aviso da mudança de estado
        _tarefas.add({"titulo": _tarefasController.text.trim(), "concluida": false});
      });
    }
  }

  void _deletarTarefa(int index) {
    if (_tarefas[index]["concluida"] == true){
      setState(() {
        _tarefas.remove(_tarefas[index]);
      });
    }
  }
}