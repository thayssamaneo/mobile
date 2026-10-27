import 'package:flutter/material.dart';
import '../controllers/livro_controller.dart';
import '../models/livro_model.dart';
import 'detalhe_livro_view.dart';
import 'widgets/livro_card_widget.dart';
import 'widgets/seletor_estante_dialog.dart';

// Tela responsável pela visualização e organização das estantes virtuais
class EstantesView extends StatelessWidget {
  final LivroController livroController;
  final String userId;

  const EstantesView({
    super.key,
    required this.livroController,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: StatusLeitura.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Minhas Estantes'),
          bottom: _construirTabBar(context),
        ),
        body: TabBarView(
          children: StatusLeitura.values.map((status) {
            return _construirAbaEstante(context, status);
          }).toList(),
        ),
      ),
    );
  }

  // Barra de abas com as três estantes principais
  PreferredSizeWidget _construirTabBar(BuildContext context) {
    return TabBar(
      isScrollable: false,
      indicatorWeight: 3,
      tabs: StatusLeitura.values.map((status) {
        return Tab(text: status.obterRotulo());
      }).toList(),
    );
  }

  // Constrói a lista de obras pertencentes a uma estante
  Widget _construirAbaEstante(BuildContext context, StatusLeitura status) {
    return ListenableBuilder(
      listenable: livroController,
      builder: (context, _) {
        final livros = livroController.obterLivrosPorStatus(status);
        if (livros.isEmpty) {
          return _construirEstadoVazioEstante(status);
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: livros.length,
          itemBuilder: (context, index) {
            final livro = livros[index];
            return LivroCardWidget(
              livro: livro,
              aoTocar: () => _aoAbrirDetalhes(context, livro),
              botaoAcao: _construirAcaoEstante(context, livro),
            );
          },
        );
      },
    );
  }

  // Ação rápida para trocar estante
  Widget _construirAcaoEstante(BuildContext context, Livro livro) {
    return IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: () => _aoTrocarStatus(context, livro),
    );
  }

  // Mensagem para quando a estante estiver sem nenhum livro cadastrado
  Widget _construirEstadoVazioEstante(StatusLeitura status) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_stories, size: 56, color: Colors.grey[400]),
            const SizedBox(height: 12),
            Text(
              'Nenhum livro na estante "${status.obterRotulo()}"',
              style: TextStyle(color: Colors.grey[600], fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  // Abre a tela de detalhes do livro da estante
  void _aoAbrirDetalhes(BuildContext context, Livro livro) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetalheLivroView(
          livro: livro,
          livroController: livroController,
          userId: userId,
          jaEstaNaEstante: true,
        ),
      ),
    );
  }

  // Altera o status da obra através do modal de seleção
  void _aoTrocarStatus(BuildContext context, Livro livro) {
    SeletorEstanteModal.exibir(
      context,
      statusAtual: livro.status,
      aoSelecionar: (novoStatus) async {
        await livroController.atualizarStatusLivro(
          userId,
          livro.id,
          novoStatus,
        );
      },
    );
  }
}
