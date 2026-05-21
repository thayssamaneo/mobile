import 'package:fit_life/model/atividade.dart';
import 'package:flutter/material.dart';

class AtividadeController extends ChangeNotifier{
  final List<Atividade> _atividadesPendentes = [];
  final List<Atividade> _atividadesConcluidas = [];

  List<Atividade> get atividadesPendentes => _atividadesPendentes;
  List<Atividade> get atividadesConcluidas => _atividadesConcluidas;

  // métodos 

  // criar nova atividade
  void createAtividade(String titulo){
    if (titulo.trim().isEmpty)return; // validação se a tarefa possui nome, se não, interrompe

    _atividadesPendentes.add(Atividade(titulo: titulo)); // adicionando uma nova atividade no vetor

    notifyListeners();
  }

  // atualizando/marcando como concluida
  void updateAtividade(int index){
      Atividade atividade = _atividadesPendentes[index];
      atividade.concluida = true;

      _atividadesConcluidas.add(atividade);
      _atividadesPendentes.removeAt(index);

      notifyListeners();

    }

    // deletando uma tarefa da lista de concluidas
    void excluirAtividadeConcl(int index){
      _atividadesConcluidas.removeAt(index);
      notifyListeners();
    }

    // deletando uma tarefa da lista de pendentes
    void excluirAtividadePend(int index){
      _atividadesPendentes.removeAt(index);
      notifyListeners();
    }

    void resetarTudo() {
      _atividadesPendentes.clear();
      _atividadesConcluidas.clear();
      notifyListeners(); // Isso fará a Dashboard e as listas zerarem instantaneamente
    }

    // métricas de saúde

    // total atividades pendentes
    int get totalAtivPend => _atividadesPendentes.length;

    // total atividades concluidas
    int get totalAtivConcl => _atividadesConcluidas.length;

    int get totalatividades => totalAtivConcl + totalAtivPend;
     
    double get porcentagemAtivConcl {
      if (totalatividades == 0) return 0;
      return (totalAtivConcl / totalatividades);
    }

    // Modo claro e escuro
    bool _darkMode = false;

    bool get isDarkMode => _darkMode;

    void mudarTema(bool valor) {
      _darkMode = valor;
      notifyListeners(); 
  }
}