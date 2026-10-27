// Modelo de dados que representa um usuário no Book Nook
class Usuario {
  final String id;
  final String email;
  final String nome;
  final DateTime? dataCadastro;

  // Construtor com os dados essenciais do usuário
  const Usuario({
    required this.id,
    required this.email,
    required this.nome,
    this.dataCadastro,
  });

  // Converte a entidade de usuário para mapa do Firestore
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nome': nome,
      'dataCadastro': (dataCadastro ?? DateTime.now()).toIso8601String(),
    };
  }

  // Instancia a entidade Usuario a partir de dados do Firestore
  factory Usuario.fromMap(Map<String, dynamic> mapa, String id) {
    return Usuario(
      id: id,
      email: mapa['email'] as String? ?? '',
      nome: mapa['nome'] as String? ?? 'Leitor',
      dataCadastro: mapa['dataCadastro'] != null
          ? DateTime.tryParse(mapa['dataCadastro'].toString())
          : null,
    );
  }
}
