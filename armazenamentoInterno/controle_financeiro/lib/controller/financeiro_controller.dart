import '../database/database_helper.dart';
import '../models/categoria_model.dart';
import '../models/transacao_model.dart';

class FinanceiroController {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Operações de Categorias

  Future<List<Categoria>> listarCategorias() async {
    final db = await _dbHelper.database;
    final result = await db.query('categorias', orderBy: 'nome ASC');
    return result.map((json) => Categoria.fromMap(json)).toList();
  }

  Future<bool> inserirCategoria(Categoria categoria) async {
    final db = await _dbHelper.database;
    
    // Verificação de duplicidade de nome
    final maps = await db.query(
      'categorias',
      where: 'LOWER(nome) = ?',
      whereArgs: [categoria.nome.toLowerCase()],
    );

    if (maps.isNotEmpty) {
      return false; // Categoria duplicada
    }

    await db.insert('categorias', categoria.toMap());
    return true;
  }

  // Operações de Transações

  Future<List<Transacao>> listarTransacoesPorCategoria(int categoriaId) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'transacoes',
      where: 'categoria_id = ?',
      whereArgs: [categoriaId],
      orderBy: 'data DESC',
    );
    return result.map((json) => Transacao.fromMap(json)).toList();
  }

  Future<void> inserirTransacao(Transacao transacao) async {
    final db = await _dbHelper.database;
    await db.insert('transacoes', transacao.toMap());
  }

  Future<Map<String, double>> obterResumoCategoria(int categoriaId) async {
    final transacoes = await listarTransacoesPorCategoria(categoriaId);
    double totalReceitas = 0;
    double totalDespesas = 0;

    for (var t in transacoes) {
      if (t.tipo == 'receita') {
        totalReceitas += t.valor;
      } else {
        totalDespesas += t.valor;
      }
    }

    return {
      'receitas': totalReceitas,
      'despesas': totalDespesas,
      'balanco': totalReceitas - totalDespesas,
    };
  }
}