import 'package:geolocator/geolocator.dart';

// Interagir com o hardware GPS e obter coordenadas exatas.
class ServicoLocalizacao {
  // Verifica se o serviço de localização (GPS) está ativo
  static Future<bool> servicoGpsAtivo() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Obtém a posição geográfica atual do usuário
  static Future<Position?> obterPosicaoAtual() async {
    final gpsAtivo = await servicoGpsAtivo();
    if (!gpsAtivo) {
      return null;
    }

  // verifica se a permissão está ativa ou não e solicita se não estiver
    LocationPermission permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) return null;
    }

    if (permissao == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }
}
