import 'package:flutter/material.dart';
import '../controllers/livro_controller.dart';
import '../models/livro_model.dart';
import 'detalhe_livro_view.dart';
import 'widgets/livro_card_widget.dart';
import 'widgets/seletor_estante_dialog.dart';

// Tela de exploração e pesquisa de livros na API OpenLibrary
class BuscaLivrosView extends StatefulWidget {
  final LivroController livroController;
  final String userId;

  const BuscaLivrosView({
    super.key,
    required this.livroController,
    required this.userId,
  });

  @override
  State<BuscaLivrosView> createState() => _BuscaLivrosViewState();
}

class _BuscaLivrosViewState extends State<BuscaLivrosView> {
  final _pesquisaController = TextEditingController();

  @override
  void dispose() {
    _pesquisaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Descobrir Livros')),
      body: Column(
        children: [
          _construirBarraPesquisa(),
          Expanded(child: _construirCorpo()),
        ],
      ),
    );
  }

  // Campo de busca com botão de submissão
  Widget _construirBarraPesquisa() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _pesquisaController,
        textInputAction: TextInputAction.search,
        onSubmitted: (_) => _dispararPesquisa(),
        decoration: InputDecoration(
          hintText: 'Pesquise por título ou autor...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: _dispararPesquisa,
          ),
        ),
      ),
    );
  }

  // Executa a busca recolhendo o teclado para liberar a renderização
  void _dispararPesquisa() {
    FocusScope.of(context).unfocus();
    widget.livroController.pesquisarObras(_pesquisaController.text);
  }

  // Constrói o corpo dinâmico dependendo do estado da busca
  Widget _construirCorpo() {
    return ListenableBuilder(
      listenable: widget.livroController,
      builder: (context, _) {
        if (widget.livroController.buscando) {
          return const Center(child: CircularProgressIndicator());
        }
        if (widget.livroController.erroBusca != null) {
          return _construirMensagemErro();
        }
        if (widget.livroController.resultadosBusca.isEmpty) {
          return _construirEstadoVazio();
        }
        return _construirListaResultados();
      },
    );
  }

  // Lista com as obras retornadas pela OpenLibrary
  Widget _construirListaResultados() {
    final livros = widget.livroController.resultadosBusca;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: livros.length,
      itemBuilder: (context, index) {
        final livro = livros[index];
        return LivroCardWidget(
          livro: livro,
          aoTocar: () => _aoAbrirDetalhes(livro),
          botaoAcao: _construirBotaoAdicionar(livro),
        );
      },
    );
  }

  // Botão rápido para adicionar a uma estante
  Widget _construirBotaoAdicionar(Livro livro) {
    return IconButton(
      icon: const Icon(Icons.add_circle_outline),
      tooltip: 'Adicionar à Estante',
      onPressed: () => _aoAdicionarLivro(livro),
    );
  }

  // Mensagem para quando nenhum livro foi buscado ou encontrado
  Widget _construirEstadoVazio() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_rounded, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 12),
            Text(
              'Encontre sua próxima leitura',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  // Mensagem em caso de erro na requisição
  Widget _construirMensagemErro() {
    return Center(
      child: Text(
        widget.livroController.erroBusca!,
        style: const TextStyle(color: Colors.redAccent),
      ),
    );
  }

  // Navega para a tela de detalhes do livro
  void _aoAbrirDetalhes(Livro livro) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetalheLivroView(
          livro: livro,
          livroController: widget.livroController,
          userId: widget.userId,
        ),
      ),
    );
  }

  // Abre seletor e salva a obra na estante no Firestore
  void _aoAdicionarLivro(Livro livro) {
    SeletorEstanteModal.exibir(
      context,
      aoSelecionar: (status) async {
        await widget.livroController.salvarNaEstante(
          widget.userId,
          livro,
          status,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Livro adicionado a "${status.obterRotulo()}"!',
              ),
            ),
          );
        }
      },
    );
  }
}
