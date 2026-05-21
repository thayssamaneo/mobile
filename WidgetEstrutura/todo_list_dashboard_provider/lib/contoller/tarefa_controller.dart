// Controler vai ter a função de provider
import 'package:flutter/material.dart';
import 'package:todo_list_dashboard_provider/model/tarefa.dart';

class TarefaController extends ChangeNotifier{
    // Transformo a classe controller em herdeira da changeNotifier (Provider)
    // Class que vai armazenar tarefas
    final List<Tarefa> _tarefas = []; // Array que vai armazenar as tarefas criadas (obj da classe model)
    // obs: _ => atriburo privado

    // Liberar o Acesso (getter)
    List<Tarefa> get tarefas => _tarefas;

    // Métodos (CRUD)

    // CREATE
    void createTarefa(String titulo){

        if(titulo.trim().isEmpty)return; // Se o título estiver vazio, interrompe os métodos

        _tarefas.add(Tarefa(titulo: titulo)); // Adicionar um obj de Tarefa ao Vetor

        notifyListeners(); // Avisar ao listeners que foi adicionado uma tarefa no vetor
    }

    // UPDATE
    void updateTarefa(int index){
        _tarefas[index].concluida = !_tarefas[index].concluida;
        // "!" -> Inverte o valor da booleana
        notifyListeners();
    }
    
    // DELETE
    void deleteTarefa(int index){
        _tarefas.removeAt(index);
        notifyListeners();
    }

    // Criar métodos para definição das métricas
    // TotalTarefas => calcula no nº total de Tarefas
    int get totalTarefas => _tarefas.length;

    // TotalTarefasConcluídas
    int get totalTarefasConcluidas => _tarefas.where((tarefa) => tarefa.concluida).length;

    // TotalTarefasPendentes
    int get totalTarefasPendentes => _tarefas.where((tarefa) => !tarefa.concluida).length;

    // Porcentagem de Tarefas Concluídas
    double get porcentagemTarefasConcluidas {
      if (totalTarefas == 0) return 0;
      return (totalTarefasConcluidas / totalTarefas) * 100;
    }
}