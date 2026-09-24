import 'dart:io';
import 'package:flutter/material.dart';
import '../models/registro_model.dart';

// Componente de cartão para exibição de cada registro na listagem.
class ItemRegistroCard extends StatelessWidget {
  final RegistroModel registro;
  final VoidCallback aoTocar;
  final VoidCallback aoExcluir;

  const ItemRegistroCard({
    super.key,
    required this.registro,
    required this.aoTocar,
    required this.aoExcluir,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: aoTocar,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              _construirMiniatura(),
              const SizedBox(width: 14),
              Expanded(child: _construirDadosPrincipais()),
              _construirBotaoExcluir(context),
            ],
          ),
        ),
      ),
    );
  }

  // Constrói a imagem em miniatura da foto salva
  Widget _construirMiniatura() {
    final arquivoFoto = File(registro.caminhoDaFoto);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 70,
        height: 70,
        color: Colors.grey[200],
        child: arquivoFoto.existsSync()
            ? Image.file(arquivoFoto, fit: BoxFit.cover)
            : const Icon(Icons.broken_image, color: Colors.grey),
      ),
    );
  }

  // Constrói os textos com data, hora, coordenadas e observação
  Widget _construirDadosPrincipais() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          registro.dataHora,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.location_on, size: 14, color: Color(0xFFC4161C)),
            const SizedBox(width: 2),
            Expanded(
              child: Text(
                registro.coordenadasFormatadas,
                style: const TextStyle(fontSize: 12, color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        if (registro.observacao.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            registro.observacao,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  // Constrói o botão de exclusão do registro
  Widget _construirBotaoExcluir(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
      onPressed: aoExcluir,
      tooltip: 'Excluir registro',
    );
  }
}
