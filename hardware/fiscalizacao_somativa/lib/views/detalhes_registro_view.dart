import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/registro_model.dart';
import '../controllers/registro_controller.dart';
import '../services/servico_feedback.dart';

class DetalhesRegistroView extends StatelessWidget {
  final RegistroModel registro;
  final RegistroController controller;

  const DetalhesRegistroView({
    super.key,
    required this.registro,
    required this.controller,
  });

  // Copia as coordenadas para a área de transferência
  void _copiarCoordenadas(BuildContext context) {
    Clipboard.setData(ClipboardData(text: registro.coordenadasFormatadas));
    ServicoFeedback.exibirMensagemSucesso(
      context,
      'Coordenadas copiadas para a área de transferência!',
    );
  }

  // Pede confirmação antes de excluir
  Future<void> _confirmarExclusao(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Registro'),
        content: const Text('Tem certeza que deseja remover este registro permanentemente?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Excluir', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmar == true && context.mounted) {
      await controller.excluirRegistro(registro.id!, registro.caminhoDaFoto);
      if (context.mounted) {
        ServicoFeedback.exibirMensagemSucesso(context, 'Registro excluído!');
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Registro'),
        backgroundColor: const Color(0xFFC4161C),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Excluir registro',
            onPressed: () => _confirmarExclusao(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _construirFotoGrande(),
            const SizedBox(height: 16),
            _construirCartaoDetalhes(context),
          ],
        ),
      ),
    );
  }

  // Constrói a exibição ampliada da foto do registro
  Widget _construirFotoGrande() {
    final arquivoFoto = File(registro.caminhoDaFoto);
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 280,
        color: Colors.black12,
        child: arquivoFoto.existsSync()
            ? Image.file(arquivoFoto, fit: BoxFit.cover)
            : const Center(
                child: Icon(Icons.broken_image, size: 64, color: Colors.grey),
              ),
      ),
    );
  }

  // Constrói o cartão com todas as informações do registro
  Widget _construirCartaoDetalhes(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _construirLinhaInfo(Icons.calendar_today, 'Data/Hora', registro.dataHora),
            const Divider(height: 24),
            _construirLinhaInfo(
              Icons.location_on,
              'Coordenadas GPS',
              'Lat: ${registro.latitude.toStringAsFixed(6)}\nLong: ${registro.longitude.toStringAsFixed(6)}',
            ),
            const SizedBox(height: 8),
            _construirBotaoCopiar(context),
            const Divider(height: 24),
            _construirLinhaInfo(
              Icons.comment_outlined,
              'Observação',
              registro.observacao.isNotEmpty ? registro.observacao : 'Nenhuma observação registrada.',
            ),
          ],
        ),
      ),
    );
  }

  // Constrói uma linha de informação com ícone, título e valor
  Widget _construirLinhaInfo(IconData icone, String titulo, String valor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icone, color: const Color(0xFFC4161C), size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 2),
              Text(valor, style: const TextStyle(fontSize: 15, color: Colors.black87)),
            ],
          ),
        ),
      ],
    );
  }

  // Constrói o botão para copiar ou interagir com as coordenadas
  Widget _construirBotaoCopiar(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFFC4161C),
        side: const BorderSide(color: Color(0xFFC4161C)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () => _copiarCoordenadas(context),
      icon: const Icon(Icons.copy, size: 16),
      label: const Text('Copiar Coordenadas GPS'),
    );
  }
}
