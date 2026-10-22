import 'package:flutter/material.dart';
import '../../models/livro_model.dart';

// Card reutilizável para exibição de uma obra literária
class LivroCardWidget extends StatelessWidget {
  final Livro livro;
  final VoidCallback? aoTocar;
  final Widget? botaoAcao;

  const LivroCardWidget({
    super.key,
    required this.livro,
    this.aoTocar,
    this.botaoAcao,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: aoTocar,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _construirCapa(context),
              const SizedBox(width: 14),
              Expanded(child: _construirInformacoes(context)),
              ?botaoAcao,
            ],
          ),
        ),
      ),
    );
  }

  // Constrói a miniatura da capa com fallback visual
  Widget _construirCapa(BuildContext context) {
    final tema = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 60,
        height: 85,
        color: tema.colorScheme.primary.withValues(alpha: 0.1),
        child: livro.capaUrl != null
            ? Image.network(
                livro.capaUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _construirIconeFallback(tema),
              )
            : _construirIconeFallback(tema),
      ),
    );
  }

  // Fallback quando não há imagem de capa disponível
  Widget _construirIconeFallback(ThemeData tema) {
    return Icon(Icons.book, size: 30, color: tema.colorScheme.primary);
  }

  // Constrói a seção de título, autores e metadados
  Widget _construirInformacoes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _construirTitulo(),
        const SizedBox(height: 4),
        _construirAutores(),
        const SizedBox(height: 8),
        _construirMetadados(context),
      ],
    );
  }

  // Título da obra com limite de duas linhas
  Widget _construirTitulo() {
    return Text(
      livro.titulo,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    );
  }

  // Nomes dos autores formatados
  Widget _construirAutores() {
    return Text(
      livro.autores.join(', '),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.grey[700], fontSize: 13),
    );
  }

  // Indicadores de páginas e idioma
  Widget _construirMetadados(BuildContext context) {
    return Row(
      children: [
        if (livro.numeroPaginas != null) ...[
          Icon(Icons.menu_book, size: 14, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            '${livro.numeroPaginas} pág.',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(width: 10),
        ],
        _construirBadgeIdioma(context),
      ],
    );
  }

  // Tag do idioma da obra
  Widget _construirBadgeIdioma(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        livro.idioma?.toUpperCase() ?? 'PT',
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
