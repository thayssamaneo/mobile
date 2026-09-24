import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServicoFeedback {
  // Emite sinal sonoro e vibração para confirmar a ação
  static Future<void> emitirSomConfirmacao() async {
    await SystemSound.play(SystemSoundType.alert);
    await HapticFeedback.heavyImpact();
  }

  // Exibe mensagem de sucesso no SnackBar
  static void exibirMensagemSucesso(BuildContext contexto, String mensagem) {
    ScaffoldMessenger.of(contexto).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(mensagem)),
          ],
        ),
        backgroundColor: const Color(0xFF007A33),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Exibe mensagem de aviso ou erro no SnackBar
  static void exibirMensagemAviso(BuildContext contexto, String mensagem) {
    ScaffoldMessenger.of(contexto).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(mensagem)),
          ],
        ),
        backgroundColor: const Color(0xFFC53030),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
