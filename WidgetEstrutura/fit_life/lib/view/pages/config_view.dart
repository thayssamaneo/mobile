import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_life/controller/atividade_controller.dart';

class ConfiguracoesView extends StatelessWidget {
  const ConfiguracoesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AtividadeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text("FitLife", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Configurações", style: TextStyle(fontSize: 14)),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: SwitchListTile(
              title: const Text("Tema Escuro"),
              subtitle: const Text("Alternar entre modo claro e escuro"),
              secondary: const Icon(Icons.brightness_6),
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (bool valor) {
                controller.mudarTema(valor);
              },
            ),
          ),

          // 2. Notificações
          Card(
            child: ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text("Configurar Notificações"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
              },
            ),
          ),

          // 3. Resetar Progresso
          Card(
            child: ListTile(
              leading: const Icon(Icons.delete_forever, color: Colors.red),
              title: const Text("Resetar Progresso", style: TextStyle(color: Colors.red)),
              subtitle: const Text("Apaga todas as atividades"),
              onTap: () => _confirmarReset(context, controller),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.dashboard, color: Colors.white), 
              onPressed: () => Navigator.pushNamed(context, '/dashboard')),
            IconButton(icon: const Icon(Icons.list, color: Colors.white), 
              onPressed: () => Navigator.pushNamed(context, '/ativMenu')),
            IconButton(icon: const Icon(Icons.settings, color: Colors.white), 
              onPressed: () {}),
          ],
        ),
      ),
    );
  }

  void _confirmarReset(BuildContext context, AtividadeController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Atenção!"),
        content: const Text("Deseja realmente apagar todo o seu progresso?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              controller.resetarTudo();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Progresso resetado com sucesso!")),
              );
            },
            child: const Text("Resetar", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}