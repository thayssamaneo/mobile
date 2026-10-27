import 'livro_model.dart';

// Modelo responsável por encapsular as métricas agregadas de leitura
class Estatisticas {
  final int totalLivros;
  final int livrosLidos;
  final int livrosLendo;
  final int livrosQueroLer;
  final int totalPaginasLidas;

  // Construtor imutável com valores padrões
  const Estatisticas({
    this.totalLivros = 0,
    this.livrosLidos = 0,
    this.livrosLendo = 0,
    this.livrosQueroLer = 0,
    this.totalPaginasLidas = 0,
  });

  // Calcula e agrega as métricas com base na lista atual de livros
  factory Estatisticas.calcular(List<Livro> livros) {
    int lidos = 0;
    int lendo = 0;
    int queroLer = 0;
    int paginas = 0;

    for (final livro in livros) {
      if (livro.status == StatusLeitura.lidos) {
        lidos++;
        paginas += livro.numeroPaginas ?? 0;
      } else if (livro.status == StatusLeitura.lendo) {
        lendo++;
      } else {
        queroLer++;
      }
    }

    return Estatisticas(
      totalLivros: livros.length,
      livrosLidos: lidos,
      livrosLendo: lendo,
      livrosQueroLer: queroLer,
      totalPaginasLidas: paginas,
    );
  }
}
