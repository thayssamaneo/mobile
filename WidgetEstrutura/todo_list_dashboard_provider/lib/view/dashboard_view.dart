import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_dashboard_provider/contoller/tarefa_controller.dart';


class DashboardView  extends StatelessWidget{
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard de Tarefas"),
      centerTitle: true,),
      body:Padding(
        padding: EdgeInsets.all(8),
        // Consumer => widget do provider que permite a modificação de estado quando recebe as informações do controller
        child: Consumer<TarefaController>(
          builder: (context, controller, child){
            return Column(
              children: [
                // Aqui teremos uma lista de Card => com as métricas determinadas pelo controller
                // TotalTarefas
                _cardDashboard(
                  titulo: "Total de Tarefas",
                  value: controller.totalTarefas.toString(),
                  icon: Icons.list_alt,
                  color: Colors.blue.shade800),
                // TotalTarefas Concluídas
                _cardDashboard(
                  titulo: "Total Tarefas Concluídas",
                  value: controller.totalTarefasConcluidas.toString(),
                  icon: Icons.check_box,
                  color: Colors.green.shade800),
                // TotalTarefaPendentes
                _cardDashboard(
                  titulo: "Total Tarefas Pendentes",
                  value: controller.totalTarefasPendentes.toString(),
                  icon: Icons.pending_actions,
                  color: Colors.orange.shade800),
                // PorcentagemTarefasConcluídas
                _cardDashboard(
                  titulo: "Porcentagem Tarefas Concluídas",
                  value: controller.porcentagemTarefasConcluidas.toString(),
                  icon: Icons.percent,
                  color: Colors.purple.shade800),
              ],
            );
          },
        ),
      ),
    );
  }
}


Widget _cardDashboard({
  required String titulo,
  required String value,
  required IconData icon,
  required Color color
}){
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      // Arredondar os cantos do card
      borderRadius: BorderRadiusGeometry.circular(12)),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.15),
        child: Icon(icon, color: color,),
      ),
      title: Text(titulo, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
      trailing: Text(value, style: TextStyle(fontSize: 24, color: color),),
    ),
  );
}
