import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// Captura de fotos e armazenamento em diretório local.
class ServicoMidia {
  static final ImagePicker _seletor = ImagePicker();

  // Captura uma foto
  static Future<String?> capturarFotoCamera() async {
    final XFile? foto = await _seletor.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: 1920,
      maxHeight: 1080,
    );
    if (foto == null) return null;
    return await salvarFotoPermanente(foto.path);
  }

  // Cria o diretório imagens/registro e salva o arquivo
  static Future<String> salvarFotoPermanente(String caminhoOrigem) async {
    final diretorioApp = await getApplicationDocumentsDirectory();
    final pastaDestino = Directory(
      p.join(diretorioApp.path, 'imagens', 'registro'),
    );

    if (!await pastaDestino.exists()) {
      await pastaDestino.create(recursive: true);
    }

    final nomeArquivo = 'registro_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final caminhoFinal = p.join(pastaDestino.path, nomeArquivo);
    final arquivoCopiado = await File(caminhoOrigem).copy(caminhoFinal);

    return arquivoCopiado.path;
  }

  // Remove o arquivo de imagem do armazenamento caso o registro seja excluído
  static Future<void> removerArquivoFoto(String caminhoFoto) async {
    try {
      final arquivo = File(caminhoFoto);
      if (await arquivo.exists()) {
        await arquivo.delete();
      }
    } catch (_) {
      // Ignora falhas na remoção física do arquivo
    }
  }
}
