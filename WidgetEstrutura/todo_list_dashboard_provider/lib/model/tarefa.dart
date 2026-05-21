class Tarefa {
    // Atributos
    String titulo;
    bool concluida;
    DateTime criadaEm;


    // Constructor
    Tarefa({required this.titulo, this.concluida = false, DateTime? criadaEm}): criadaEm = criadaEm ?? DateTime.now();

}