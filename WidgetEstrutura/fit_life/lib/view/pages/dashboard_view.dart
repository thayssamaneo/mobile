import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_life/controller/atividade_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Escutando o controller para pegar as métricas em tempo real
    final controller = context.watch<AtividadeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text("FitLife", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Dashboard", style: TextStyle(fontSize: 14)),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Center(child: Text("Menu FitLife", style: TextStyle(color: Colors.white, fontSize: 24))),
            ),
            ListTile(title: const Text("Dashboard"), selected: true, onTap: () => Navigator.pop(context)),
            ListTile(title: const Text("Atividades Pendentes"), onTap: () => Navigator.pushNamed(context, '/ativMenu')),
            ListTile(title: const Text("Atividades Concluídas"), onTap: () => Navigator.pushNamed(context, '/concluidas')),
            ListTile(title: const Text("Configurações"), onTap: () => Navigator.pushNamed(context, '/config')),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _metricas("Concluídas", "${controller.totalAtivConcl}", Icons.check_circle),
            _metricas("Pendentes", "${controller.totalAtivPend}", Icons.pending_actions),
            _metricas("Progresso", "${(controller.porcentagemAtivConcl * 100).toInt()}%", Icons.trending_up),
            _metricas("Total Geral", "${controller.totalatividades}", Icons.bar_chart),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.dashboard), onPressed: () {}),
            IconButton(icon: const Icon(Icons.add_circle), onPressed: () {
              Navigator.pushNamed(context, '/ativMenu');
            }),
            IconButton(icon: const Icon(Icons.settings), onPressed: () {
              Navigator.pushNamed(context, '/config');
            }),
          ],
        ),
      ),
    );
  }

  Widget _metricas(String titulo, String valor, IconData icone) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[200], 
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icone, color: Colors.blue, size: 30),
          const SizedBox(height: 10),
          Text(valor, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text(titulo, style: const TextStyle(fontSize: 14,)),
        ],
      ),
    );
  }
}