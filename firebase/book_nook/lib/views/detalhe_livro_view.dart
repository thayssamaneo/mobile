import 'package:flutter/material.dart';
import '../controllers/livro_controller.dart';
import '../models/livro_model.dart';
import 'widgets/seletor_estante_dialog.dart';

// Tela que exibe detalhes aprofundados da obra e ações de gerenciamento
class DetalheLivroView extends StatefulWidget {
  final Livro livro;
  final LivroController livroController;
  final String userId;
  final bool jaEstaNaEstante;

  const DetalheLivroView({
    super.key,
    required this.livro,
    required this.livroController,
    required this.userId,
    this.jaEstaNaEstante = false,
  });

  @override
  State<DetalheLivroView> createState() => _DetalheLivroViewState();
}

class _DetalheLivroViewState extends State<DetalheLivroView> {
  late Livro _livroAtual;

  @override
  void initState() {
    super.initState();
    _livroAtual = widget.livro;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Livro'),
        actions: [
          if (widget.jaEstaNaEstante) _construirBotaoExcluir(),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _construirCapaDestaque(),
            const SizedBox(height: 20),
            _construirCabecalhoLivro(),
            const SizedBox(height: 20),
            _construirGradeMetadados(),
            const SizedBox(height: 30),
            _construirBotaoAcaoEstante(),
          ],
        ),
      ),
    );
  }

  // Constrói a capa ampliada em destaque
  Widget _construirCapaDestaque() {
    return Center(
      child: Container(
        height: 220,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: _livroAtual.capaUrl != null
              ? Image.network(_livroAtual.capaUrl!, fit: BoxFit.cover)
              : Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.book, size: 64, color: Colors.grey),
                ),
        ),
      ),
    );
  }

  // Título e autores principais da obra
  Widget _construirCabecalhoLivro() {
    return Column(
      children: [
        Text(
          _livroAtual.titulo,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          _livroAtual.autores.join(', '),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }

  // Grid ou linha de metadados da edição
  Widget _construirGradeMetadados() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _construirItemMetadado(
          'Páginas',
          _livroAtual.numeroPaginas != null
              ? '${_livroAtual.numeroPaginas}'
              : 'N/A',
          Icons.menu_book,
        ),
        _construirItemMetadado(
          'Idioma',
          _livroAtual.idioma?.toUpperCase() ?? 'PT',
          Icons.language,
        ),
        _construirItemMetadado(
          'Estante',
          _livroAtual.status.obterRotulo(),
          Icons.bookmark,
        ),
      ],
    );
  }

  // Widget de item individual de metadado
  Widget _construirItemMetadado(String rotulo, String valor, IconData icone) {
    return Column(
      children: [
        Icon(icone, size: 22, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 6),
        Text(valor, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(rotulo, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  // Botão para salvar ou alterar estante
  Widget _construirBotaoAcaoEstante() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.swap_horiz),
        label: Text(
          widget.jaEstaNaEstante
              ? 'Alterar Estante'
              : 'Adicionar à Minha Estante',
        ),
        onPressed: _aoAbrirSeletorEstante,
      ),
    );
  }

  // Botão de remoção na barra de aplicativo
  Widget _construirBotaoExcluir() {
    return IconButton(
      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
      onPressed: _aoConfirmarExclusao,
    );
  }

  // Abre o modal de seleção de estante
  void _aoAbrirSeletorEstante() {
    SeletorEstanteModal.exibir(
      context,
      statusAtual: _livroAtual.status,
      aoSelecionar: (novoStatus) async {
        await widget.livroController.salvarNaEstante(
          widget.userId,
          _livroAtual,
          novoStatus,
        );
        setState(() => _livroAtual = _livroAtual.copyWith(status: novoStatus));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Livro movido para "${novoStatus.obterRotulo()}"!',
              ),
            ),
          );
        }
      },
    );
  }

  // Diálogo de confirmação para exclusão da obra
  Future<void> _aoConfirmarExclusao() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remover da Estante?'),
        content: const Text(
          'Esta ação removerá o livro da sua estante permanentemente.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Remover', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmar == true && mounted) {
      await widget.livroController.excluirDaEstante(widget.userId, _livroAtual.id);
      if (mounted) Navigator.pop(context);
    }
  }
}
