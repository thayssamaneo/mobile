import 'package:flutter/material.dart';
import '../../models/livro_model.dart';

// Modal inferior para seleção ou alteração de estante de leitura
class SeletorEstanteModal extends StatelessWidget {
  final StatusLeitura? statusAtual;
  final ValueChanged<StatusLeitura> aoSelecionar;

  const SeletorEstanteModal({
    super.key,
    this.statusAtual,
    required this.aoSelecionar,
  });

  // Exibe o modal inferior de seleção de estante
  static Future<void> exibir(
    BuildContext context, {
    StatusLeitura? statusAtual,
    required ValueChanged<StatusLeitura> aoSelecionar,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SeletorEstanteModal(
        statusAtual: statusAtual,
        aoSelecionar: aoSelecionar,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _construirTitulo(context),
            const SizedBox(height: 12),
            ...StatusLeitura.values.map((s) => _construirOpcao(context, s)),
          ],
        ),
      ),
    );
  }

  // Constrói o cabeçalho textual do modal
  Widget _construirTitulo(BuildContext context) {
    return const Text(
      'Selecione a Estante',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  // Constrói cada item de estante disponível
  Widget _construirOpcao(BuildContext context, StatusLeitura status) {
    final estaSelecionado = status == statusAtual;
    final tema = Theme.of(context);

    return ListTile(
      leading: Icon(
        _obterIconePorStatus(status),
        color: estaSelecionado ? tema.colorScheme.primary : Colors.grey[600],
      ),
      title: Text(
        status.obterRotulo(),
        style: TextStyle(
          fontWeight: estaSelecionado ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: estaSelecionado
          ? Icon(Icons.check, color: tema.colorScheme.primary)
          : null,
      onTap: () {
        Navigator.pop(context);
        aoSelecionar(status);
      },
    );
  }

  // Mapeia o ícone representativo de cada status de leitura
  IconData _obterIconePorStatus(StatusLeitura status) {
    switch (status) {
      case StatusLeitura.queroLer:
        return Icons.bookmark_add_outlined;
      case StatusLeitura.lendo:
        return Icons.auto_stories_outlined;
      case StatusLeitura.lidos:
        return Icons.task_alt_outlined;
    }
  }
}
