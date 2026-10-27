import 'package:flutter_test/flutter_test.dart';
import 'package:book_nook/models/livro_model.dart';
import 'package:book_nook/models/estatisticas_model.dart';

// Testes unitários para validar a lógica de negócios e cálculos de estatísticas
void main() {
  test('deve criar Livro a partir do mapa do Firestore', () {
    final mapa = {
      'titulo': 'Dom Casmurro',
      'autores': ['Machado de Assis'],
      'numeroPaginas': 256,
      'status': 'lidos',
    };

    final livro = Livro.fromMap(mapa, 'id_123');
    expect(livro.titulo, 'Dom Casmurro');
    expect(livro.status, StatusLeitura.lidos);
  });

  test('deve calcular estatísticas agregadas com precisão', () {
    final livros = [
      const Livro(
        id: '1',
        titulo: 'Livro 1',
        numeroPaginas: 100,
        status: StatusLeitura.lidos,
      ),
      const Livro(
        id: '2',
        titulo: 'Livro 2',
        numeroPaginas: 200,
        status: StatusLeitura.lendo,
      ),
      const Livro(
        id: '3',
        titulo: 'Livro 3',
        numeroPaginas: 150,
        status: StatusLeitura.queroLer,
      ),
    ];

    final estatisticas = Estatisticas.calcular(livros);

    expect(estatisticas.totalLivros, 3);
    expect(estatisticas.livrosLidos, 1);
    expect(estatisticas.livrosLendo, 1);
    expect(estatisticas.livrosQueroLer, 1);
    expect(estatisticas.totalPaginasLidas, 100);
  });
}
