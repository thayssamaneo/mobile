import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_dashboard_provider/contoller/tarefa_controller.dart';
import 'package:todo_list_dashboard_provider/view/dashboard_view.dart';

class TarefaView extends StatefulWidget {
    const TarefaView({super.key});

    @override
    State<TarefaView> createState() => _TarefaViewState();
}

class _TarefaViewState extends State<TarefaView> {
    // Controlador do input
    final TextEditingController _tarefaInput = TextEditingController();


    @override
    Widget build(BuildContext context) {
        // Controller das funções do CRUD para operar no build
        final tarefaController = Provider.of<TarefaController>(context);

        return Scaffold(
            appBar:AppBar(
                title: Text("Gerenciador de Tarefas"),
                centerTitle: true,
                actions: [
                    IconButton(
                        onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>DashboardView()));
                        },
                        icon: Icon(Icons.arrow_circle_right)
                    )
                ],
            ),
            body: Padding(padding: EdgeInsets.all(8), child:
            Column(
                children: [
                    // Input do texto da tarefa
                    TextField(
                        controller: _tarefaInput,
                        decoration: InputDecoration(
                            // Placeholder
                            labelText: "Digite a tarefa...",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            suffix: IconButton(
                                onPressed: () {
                                    // Ao pressionar o botão '+' adiciona a tarefa ao vetor
                                    tarefaController.createTarefa(_tarefaInput.text);
                                    // Limpa o campo do input
                                    _tarefaInput.clear();
                                },
                                icon: Icon(Icons.add, color: Colors.green),
                            )
                        ),
                    ),
                    // Lista com as tarefas
                    // Expanded parmite o scroll de parte da tela
                    Expanded(
                        child: tarefaController.tarefas.isEmpty ? Center(child: Text("Nenhuma tarefa foi adicionada"),) : ListView.builder(
                            itemCount: tarefaController.tarefas.length,
                            itemBuilder: (context, index){
                                // Será construído algo para cada elemento da lista (ForEach)
                                final tarefa = tarefaController.tarefas[index];
                                return Card(
                                    elevation: 3,
                                    margin: EdgeInsets.all(6),
                                    child: ListTile(
                                        leading: Checkbox(
                                            value: tarefa.concluida,
                                            // O value não importa, o que mporta é a execução do método, método que vai inverter o valor da terafa (true <--> false)
                                            onChanged: (_)=> tarefaController.updateTarefa(index)
                                        ),
                                        title: Text(tarefa.titulo),
                                        subtitle: Text(tarefa.concluida ? "Concluída" : "Pendente"),
                                        trailing: IconButton(
                                            onPressed: ()=> tarefaController.deleteTarefa(index),
                                                icon: Icon(Icons.delete, color: Colors.red,)
                                        ),
                                    ),
                                );
                            }
                        )
                    )
                ],
            ),),
        );
    }
}