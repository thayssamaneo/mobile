import 'package:fit_life/controller/atividade_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AtividadesPendentes extends StatelessWidget {
  const AtividadesPendentes({super.key});

  @override
  Widget build(BuildContext context) {
    // Acessando o controller para pegar a lista de atividades
    final controller = context.watch<AtividadeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text("FitLife", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Atividades pendentes", style: TextStyle(fontSize: 14)),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),

      // menu lateral
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
              onTap: () => Navigator.pushNamed(context, '/dashboard'),
            ),
            ListTile(
              title: const Text("Atividades pendentes"),
              selected: true,
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text("Atividades concluídas"),
              onTap: () => Navigator.pushNamed(context, '/concluidas'),
            ),
            ListTile(
              title: const Text("Configurações"),
              onTap: () => Navigator.pushNamed(context, '/config'),
            ),
          ],
        ),
      ),

      body: controller.atividadesPendentes.isEmpty
          ? const Center(child: Text("Nenhuma atividade pendente!"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.atividadesPendentes.length,
              itemBuilder: (context, index) {
                final atividade = controller.atividadesPendentes[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(atividade.titulo, style: const TextStyle(fontSize: 18)),
                    trailing: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent, 
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.check, color: Colors.white),
                        onPressed: () {
                          controller.updateAtividade(index);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: const Icon(Icons.dashboard), onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              }),
              IconButton(icon: const Icon(Icons.add_circle, size: 30), onPressed: () {
                final TextEditingController textController = TextEditingController();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Nova Atividade"),
                      content: TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                          hintText: "Digite o nome da atividade...",
                        ),
                        autofocus: true,
                      ),
                      actions: [
                        // Botão Cancelar
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancelar"),
                        ),
                        // Botão Adicionar
                        ElevatedButton(
                          onPressed: () {
                            if (textController.text.trim().isNotEmpty) {
                              Provider.of<AtividadeController>(context, listen: false)
                                  .createAtividade(textController.text);
                              
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Adicionar"),
                        ),
                      ],
                    );
                  },
                );
              }),
              IconButton(icon: const Icon(Icons.settings), onPressed: () {
                Navigator.pushNamed(context, '/config');
              }),
            ],
          ),
        ),
      ),
    );
  }
}