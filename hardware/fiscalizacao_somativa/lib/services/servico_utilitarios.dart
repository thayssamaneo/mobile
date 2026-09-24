class ServicoUtilitarios {
  // Formata uma data DateTime para o padrão brasileiro dd/MM/yyyy HH:mm:ss
  static String formatarDataHora(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final ano = data.year.toString();
    final hora = data.hour.toString().padLeft(2, '0');
    final min = data.minute.toString().padLeft(2, '0');
    final seg = data.second.toString().padLeft(2, '0');
    return '$dia/$mes/$ano $hora:$min:$seg';
  }

  // Gera o link web para visualização da coordenada no mapa
  static String gerarUrlMapa(double latitude, double longitude) {
    return 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  }
}
