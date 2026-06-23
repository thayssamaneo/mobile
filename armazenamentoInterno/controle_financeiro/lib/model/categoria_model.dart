class Categoria {
  //atributos
  final int? id;
  final String nome;
  final String descricao;

  // construtor
  Categoria({
    this.id,
    required this.nome,
    required this.descricao,
  });

  // Converter um objeto Categoria em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
    };
  }

  // Criar um objeto Categoria a partir de um Map vindo do banco de dados
  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      descricao: map['descricao'] as String,
    );
  }
}