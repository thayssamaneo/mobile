import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/registro_model.dart';

class BancoDadosHelper {
  static final BancoDadosHelper instancia = BancoDadosHelper._construtorPrivado();
  static Database? _bancoDados;

  BancoDadosHelper._construtorPrivado();

  // Retorna o obj ativo do banco ou inicializa se ainda não existir
  Future<Database> get bancoDados async {
    if (_bancoDados != null) return _bancoDados!;
    _bancoDados = await _inicializarBanco();
    return _bancoDados!;
  }

  // Inicializa o banco de dados definindo caminho e versão
  Future<Database> _inicializarBanco() async {
    final caminhoDiretorio = await getDatabasesPath();
    final caminhoCompleto = join(caminhoDiretorio, 'senai_checkin.db');

    return await openDatabase(
      caminhoCompleto,
      version: 1,
      onCreate: _criarTabelas,
    );
  }

  // Cria a tabela de registros
  Future<void> _criarTabelas(Database db, int versao) async {
    await db.execute('''
      CREATE TABLE registros (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        data_hora TEXT NOT NULL,
        caminho_da_foto TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        observacao TEXT
      )
    ''');
  }

  // Insere um novo registro no banco SQLite e retorna o ID gerado
  Future<int> inserirRegistro(RegistroModel registro) async {
    final db = await bancoDados;
    return await db.insert(
      'registros',
      registro.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // caso hajam dois registros iguais, o mais recente substitui o mais antigo
    );
  }

  // Retorna todos os registros ordenados do mais recente para o mais antigo
  Future<List<RegistroModel>> obterTodosRegistros() async {
    final db = await bancoDados;
    final resultado = await db.query(
      'registros',
      orderBy: 'id DESC', // comando SQL para ordenar os registros de forma decrescente
    );
    return resultado.map((item) => RegistroModel.fromMap(item)).toList();
  }

  // Obtém um registro específico pelo id
  Future<RegistroModel?> obterRegistroPorId(int id) async {
    final db = await bancoDados;
    final resultado = await db.query(
      'registros',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1, // limita para que só retorne 1 registro
    );
    if (resultado.isNotEmpty) {
      return RegistroModel.fromMap(resultado.first);
    }
    return null;
  }

  // Remove um registro específico pelo ID
  Future<int> deletarRegistro(int id) async {
    final db = await bancoDados;
    return await db.delete(
      'registros',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Fecha a conexão com o banco de dados SQLite
  Future<void> fecharBanco() async {
    final db = _bancoDados;
    if (db != null) {
      await db.close();
      _bancoDados = null;
    }
  }
}
