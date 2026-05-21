import 'package:fit_life/controller/atividade_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AtividadesConcluidasView extends StatelessWidget {
  const AtividadesConcluidasView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AtividadeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text("FitLife", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Atividades concluídas", style: TextStyle(fontSize: 14)),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent, 
      ),

      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Center(
                child: Text("Menu FitLife", style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
            ),
            ListTile(
              title: const Text("Dashboard"),
              onTap: () => Navigator.pushNamed(context, '/dashboard'), // Exemplo de rota
            ),
            ListTile(
              title: const Text("Atividades pendentes"),
              onTap: () => Navigator.pushNamed(context, '/ativMenu'),
            ),
            ListTile(
              title: const Text("Atividades concluídas"),
              selected: true,
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text("Configurações"),
              onTap: () => Navigator.pushNamed(context, '/config'),
            ),
          ],
        ),
      ),

      body: controller.totalAtivConcl == 0
          ? const Center(child: Text("Nenhuma atividade concluída ainda!"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.totalAtivConcl,
              itemBuilder: (context, index) {
                final atividade = controller.atividadesConcluidas[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(
                      atividade.titulo,
                      style: const TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    trailing: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent, 
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          controller.excluirAtividadeConcl(index);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.dashboard, color: Colors.white), onPressed: () {
              Navigator.pushNamed(context, '/dashboard');
            }),
            IconButton(icon: const Icon(Icons.add_circle, color: Colors.white), onPressed: () {
              Navigator.pushNamed(context, '/ativMenu');
            }),
            IconButton(icon: const Icon(Icons.settings, color: Colors.white), onPressed: () {
              Navigator.pushNamed(context, '/config');
            }),
          ],
        ),
      ),
    );
  }
}