// Modelo de dados que representa um registro de fiscalização/ponto no SENAI CheckIn.
class RegistroModel {
  final int? id;
  final String dataHora;
  final String caminhoDaFoto;
  final double latitude;
  final double longitude;
  final String observacao;

  // Construtor
  RegistroModel({
    this.id,
    required this.dataHora,
    required this.caminhoDaFoto,
    required this.latitude,
    required this.longitude,
    required this.observacao,
  });

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data_hora': dataHora,
      'caminho_da_foto': caminhoDaFoto,
      'latitude': latitude,
      'longitude': longitude,
      'observacao': observacao,
    };
  }

  // fromMap
  factory RegistroModel.fromMap(Map<String, dynamic> mapa) {
    return RegistroModel(
      id: mapa['id'] as int?,
      dataHora: mapa['data_hora'] as String,
      caminhoDaFoto: mapa['caminho_da_foto'] as String,
      latitude: (mapa['latitude'] as num).toDouble(),
      longitude: (mapa['longitude'] as num).toDouble(),
      observacao: (mapa['observacao'] as String?) ?? '',
    );
  }

  // Retorna as coordenadas para exibição textual
  String get coordenadasFormatadas {
    return '${latitude.toStringAsFixed(5)}, ${longitude.toStringAsFixed(5)}';
  }

  // Cria uma cópia do objeto
  RegistroModel copiarCom({
    int? id,
    String? dataHora,
    String? caminhoDaFoto,
    double? latitude,
    double? longitude,
    String? observacao,
  }) {
    return RegistroModel(
      id: id ?? this.id,
      dataHora: dataHora ?? this.dataHora,
      caminhoDaFoto: caminhoDaFoto ?? this.caminhoDaFoto,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      observacao: observacao ?? this.observacao,
    );
  }
}
