import 'package:flutter/material.dart';

class CartaoCoordenadas extends StatelessWidget {
  final double? latitude;
  final double? longitude;
  final String? dataHora;
  final VoidCallback aoPressionarAtualizar;

  const CartaoCoordenadas({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.dataHora,
    required this.aoPressionarAtualizar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFFF0F4F8),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            _construirIconeGps(),
            const SizedBox(width: 12),
            Expanded(child: _construirInformacoes()),
            IconButton(
              tooltip: 'Atualizar GPS',
              icon: const Icon(Icons.my_location, color: Color(0xFFC4161C)),
              onPressed: aoPressionarAtualizar,
            ),
          ],
        ),
      ),
    );
  }

  // Ícone
  Widget _construirIconeGps() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFC4161C).withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.location_on, color: Color(0xFFC4161C), size: 24),
    );
  }

  // Texto com coordenadas
  Widget _construirInformacoes() {
    if (latitude != null && longitude != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lat: ${latitude!.toStringAsFixed(6)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Text(
            'Long: ${longitude!.toStringAsFixed(6)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          if (dataHora != null)
            Text(
              'Data: $dataHora',
              style: const TextStyle(fontSize: 11, color: Colors.black54),
            ),
        ],
      );
    }
    return const Text(
      'Aguardando localização GPS...',
      style: TextStyle(color: Colors.black54, fontStyle: FontStyle.italic),
    );
  }
}
