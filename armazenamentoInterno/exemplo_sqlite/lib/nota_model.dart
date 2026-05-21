// modelagem de dados

class Nota{
  // atributos
  final int? id; // ? --> permite que a variável seja nula
  // Em um primeiro momento a variável é nula
  // somente quando cair no DB irá exceder o valor para o ID
  final String titulo;
  final String conteudo;

  // construtor
  Nota({this.id, required this.titulo, required this.conteudo}); // titulo e conteudo obrigatórios

  // métodos de serialização de dados (toMap(), fromMap())
  
  // toMap() => converter um obj da classe nota para MAP de DB (inserir dados no DB)
  Map<String,dynamic> toMap(){
    return{
      "id": id,
      "titulo": titulo,
      "conteudo": conteudo
    };
  }// lista não ordenada de chave e valor

  // Converter um MAP vindo do DB para obj da classe
  // para fazer o from vamos usar um factory
  factory Nota.fromMap(Map<String, dynamic> map){
    return Nota(
      id: map["id"] as int, // se está voltando do DB então já tem id
      titulo: map["titulo"] as String,
      conteudo: map["conteudo"] as String,
    );
  }

  // método para imprimir dados
  @override
  String toString(){
    return "Nota{id:$id, titulo: $titulo, conteudo: $conteudo}";
  }

}