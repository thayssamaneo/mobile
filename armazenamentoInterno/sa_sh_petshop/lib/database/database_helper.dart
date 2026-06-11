import 'package:path/path.dart';
import 'package:sa_petshop_sqlite/model/consulta_model.dart';
import 'package:sa_petshop_sqlite/model/pet_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();// _internal() --> classe de instância única (roda apenas um objeto por vez, para usar outro objeto, tem que matar o último...)
  
  
  // Singleton --> classe que permite que somente um instânciamento de obj seja feita por vez

  // Construir o Singleton
  // Essa Classe não possui um Construtor Normal, ele precisa do factory para estabelecer a conexão
  DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  // Conector do Banco e Dados
  Database? _database; //Privado

  // Get database
  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }



  Future<Database> _initDb() async{
    // Pegar o armazenamento do banco
    String path = join(await getDatabasesPath(), "petshop.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async{
      await db.execute('''CREATE TABLE pets(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      raca TEXT,
      nomeDono TEXT,
      telefoneDono TEXT)''');
      await db.execute(
        '''CREATE TABLE consultas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        petId INTEGER,
        tipoServico TEXT,
        dataHora TEXT,
        observacoes TEXT,
        FOREIGN KEY(petId) REFERENCES pets(id) ON DELETE CASCADE)''');
    },
    onConfigure: (db) async => await db.execute("RPAGMA foreign_keys = ON"), //DELETE on CASCADE
    );
  }

  // Métodos CRUD Simplificados
  // Inserir pet no BD
  Future<int> insertPet(Pet pet) async => (await database).insert ("pets", pet.toMap());

  // LIstar Pets no BD
  Future<List<Pet>> getPets() async{
    final List<Map<String,dynamic>> maps = await (await database).query ("pets", orderBy: "nome ASC");
    return List.generate(maps.length, (e) => Pet.fromMap(maps[e]));
  }

  // InsertConsulta
  Future<int> InsertConsulta(Consulta c) async => (await database). insert("consultas", c.toMap());

  // Get consultas por Pet
  Future<List<Consulta>> getConsultasPorPet(int petId) async {
    final List<Map<String,dynamic>> maps = await (await database).query("consultas", where: "petId = ?", whereArgs: [petId], orderBy: "dataHora DESC");
    return List.generate(maps.length, (e) => Consulta.fromMap(maps[e]));
  }
}