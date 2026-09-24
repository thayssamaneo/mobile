import 'dart:io';
import 'package:flutter/material.dart';

class CartaoFotoPreview extends StatelessWidget {
  final String? caminhoFoto;
  final VoidCallback aoPressionarCaptura;

  const CartaoFotoPreview({
    super.key,
    required this.caminhoFoto,
    required this.aoPressionarCaptura,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: aoPressionarCaptura,
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFC4161C), width: 1.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: _construirConteudo(),
        ),
      ),
    );
  }

  // Constrói a imagem capturada ou o placeholder indicativo
  Widget _construirConteudo() {
    if (caminhoFoto != null) {
      return Image.file(
        File(caminhoFoto!),
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
    return _construirPlaceholder();
  }

  // Constrói o layout inicial convidando para tirar a foto
  Widget _construirPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.camera_alt_rounded, size: 54, color: Color(0xFFC4161C)),
        SizedBox(height: 12),
        Text(
          'Toque para capturar a foto',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFFC4161C),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Câmera do dispositivo',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
