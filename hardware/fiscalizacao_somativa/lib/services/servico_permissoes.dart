import 'package:permission_handler/permission_handler.dart';

class ServicoPermissoes {
  // Verifica e solicita a permissão de acesso à câmera
  static Future<bool> solicitarPermissaoCamera() async {
    final status = await Permission.camera.status;
    if (status.isGranted) return true;

    final resultado = await Permission.camera.request();
    return resultado.isGranted;
  }

  // Verifica se a permissão de câmera foi negada permanentemente
  static Future<bool> cameraNegadaPermanentemente() async {
    final status = await Permission.camera.status;
    return status.isPermanentlyDenied || status.isRestricted;
  }

  // Verifica e solicita a permissão de acesso à localização GPS
  static Future<bool> solicitarPermissaoLocalizacao() async {
    final status = await Permission.locationWhenInUse.status;
    if (status.isGranted) return true;

    final resultado = await Permission.locationWhenInUse.request();
    return resultado.isGranted;
  }

  // Verifica se a permissão de localização foi negada permanentemente
  static Future<bool> localizacaoNegadaPermanentemente() async {
    final status = await Permission.locationWhenInUse.status;
    return status.isPermanentlyDenied || status.isRestricted;
  }

  // Abre as configurações do sistema para o usuário conceder permissões manuais
  static Future<bool> abrirConfiguracoesDoApp() async {
    return await openAppSettings();
  }
}
