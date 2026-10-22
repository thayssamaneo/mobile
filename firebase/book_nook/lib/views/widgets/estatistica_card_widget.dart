import 'package:flutter/material.dart';

// Card que exibe um indicador ou métrica do painel de leitura
class EstatisticaCardWidget extends StatelessWidget {
  final String rotulo;
  final String valor;
  final IconData icone;
  final Color? corIcone;

  const EstatisticaCardWidget({
    super.key,
    required this.rotulo,
    required this.valor,
    required this.icone,
    this.corIcone,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final cor = corIcone ?? tema.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _construirCabecalho(cor),
          const SizedBox(height: 14),
          _construirValor(),
          const SizedBox(height: 4),
          _construirRotulo(),
        ],
      ),
    );
  }

  // Constrói o ícone com fundo translúcido
  Widget _construirCabecalho(Color cor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icone, color: cor, size: 24),
    );
  }

  // Valor numérico em destaque
  Widget _construirValor() {
    return Text(
      valor,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
    );
  }

  // Rótulo explicativo da métrica
  Widget _construirRotulo() {
    return Text(
      rotulo,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey[600],
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
