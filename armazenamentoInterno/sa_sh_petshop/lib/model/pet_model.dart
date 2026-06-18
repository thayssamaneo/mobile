class Pet{
  int? id; // Pode ser nulo inicialmente
  // A gente atribuiu todas as informações, menos o ID, ele vai atribuir um id (AUTO INCREMENT) automaticamente pelo Banco de Dados
  String nome;
  String raca;
  String nomeDono;
  String telefone;

  // Construtor
  Pet({this.id, required this.nome, required this.raca, required this.nomeDono, required this.telefone});

  // Mapeamento de dados do BD
  // toMap

  // MAPEAMENTO DE DADOS
  // toMap --> Converte os valores para banco de dados
  // fromMap --> Converte os valores do banco para a tela UI
  
  Map<String,dynamic> toMap(){
    return{
      "id": id,
      "nome": nome,
      "raca": raca,
      "nomeDono": nomeDono,
      "telefone": telefone
    };
  }

  // FromMap

  // Factory --> Usa o construtor para fazer algo
  factory Pet.fromMap(Map<String,dynamic> map){
    return Pet(
      id: map["id"],
      nome: map["nome"],
      raca: map["raca"],
      nomeDono: map["nomeDono"],
      telefone: map["telefone"],
    );
  }
}

