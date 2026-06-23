class Transacao {
  // atributos
  final int? id;
  final int categoriaId;
  final String descricao;
  final double valor;
  final String data;
  final String tipo; // 'receita' ou 'despesa'

  // construtor
  Transacao({
    this.id,
    required this.categoriaId,
    required this.descricao,
    required this.valor,
    required this.data,
    required this.tipo,
  });

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoria_id': categoriaId,
      'descricao': descricao,
      'valor': valor,
      'data': data,
      'tipo': tipo,
    };
  }

  // fromMap
  factory Transacao.fromMap(Map<String, dynamic> map) {
    return Transacao(
      id: map['id'] as int?,
      categoriaId: map['categoria_id'] as int,
      descricao: map['descricao'] as String,
      valor: (map['valor'] as num).toDouble(),
      data: map['data'] as String,
      tipo: map['tipo'] as String,
    );
  }
}