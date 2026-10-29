import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../controllers/livro_controller.dart';
import '../models/estatisticas_model.dart';
import 'widgets/estatistica_card_widget.dart';

// Tela de exibição das métricas e estatísticas consolidadas de leitura
class EstatisticasView extends StatelessWidget {
  final LivroController livroController;
  final AuthController? authController;

  const EstatisticasView({
    super.key,
    required this.livroController,
    this.authController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estatísticas de Leitura'),
        actions: [
          if (authController != null)
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Sair',
              onPressed: () => _aoConfirmarLogout(context),
            ),
        ],
      ),
      body: ListenableBuilder(
        listenable: livroController,
        builder: (context, _) {
          final stats = livroController.estatisticas;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _construirCardProgressoGeral(context, stats),
                const SizedBox(height: 20),
                _construirTituloSecao('Visão Geral'),
                const SizedBox(height: 12),
                _construirGradeMetricas(stats),
              ],
            ),
          );
        },
      ),
    );
  }

  // Título padrão para seções do painel
  Widget _construirTituloSecao(String titulo) {
    return Text(
      titulo,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  // Card com barra de progresso de conclusão de livros
  Widget _construirCardProgressoGeral(
    BuildContext context,
    Estatisticas stats,
  ) {
    final percentual = stats.totalLivros > 0
        ? (stats.livrosLidos / stats.totalLivros)
        : 0.0;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Progresso da Estante',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '${(percentual * 100).toStringAsFixed(1)}% das obras concluídas',
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percentual,
              minHeight: 10,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation(Colors.amber),
            ),
          ),
        ],
      ),
    );
  }

  // Grade de cartões de indicadores
  Widget _construirGradeMetricas(Estatisticas stats) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: EstatisticaCardWidget(
                rotulo: 'Total de Obras',
                valor: '${stats.totalLivros}',
                icone: Icons.library_books,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: EstatisticaCardWidget(
                rotulo: 'Páginas Lidas',
                valor: '${stats.totalPaginasLidas}',
                icone: Icons.menu_book,
                corIcone: Colors.blueAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: EstatisticaCardWidget(
                rotulo: 'Lidos',
                valor: '${stats.livrosLidos}',
                icone: Icons.task_alt,
                corIcone: Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: EstatisticaCardWidget(
                rotulo: 'Em Leitura',
                valor: '${stats.livrosLendo}',
                icone: Icons.auto_stories,
                corIcone: Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Diálogo para confirmação do encerramento de sessão
  Future<void> _aoConfirmarLogout(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Encerrar Sessão'),
        content: const Text('Deseja realmente sair da sua conta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Sair', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      livroController.limparEstantes();
      await authController?.encerrarSessao();
    }
  }
}
