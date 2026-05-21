class Atividade {
  // Atributos
  String titulo;
  bool concluida;
  DateTime criadaEm;

  // Construtor
  Atividade({required this.titulo, this.concluida = false, DateTime? dataCriacao,}): criadaEm = dataCriacao ?? DateTime.now();
}