class DatabaseHelper {
  // transforma essa classe em singleton
  // não permite instanciar outro obj enquanto um obj estiver ativo
  static final DatabaseHelper _instance = DatabaseHelper()._internal();

  // construir o singleton
  // essa classe não possui um construtor normal, ele precisa do factory para estabelecer a conexão
  factory DatabaseHelper() => _instance;

  // conector do banco de dados
  Database? _database;

  // get dtbase
  Future<Database> get database async{
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database;
  }

  Future<Database> _initDb() async{
    // pegar o armazenamento do banco
    String path = join(await getDataBasesPath(), "petshop.db");
    return await openDataBase(
      path,
      version: 1,
      onCreate: (db, version) async{
        await db.execute('''CREATE TABLE pets(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, raca TEXT, nomeDono TEXT, telefoneDono TEXT)''');
        await db.execute('''CREATE TABLE consultas(id INTEGER PRIMARY KEY AUTOINCREMENT, petId INTEGER, tipoServico TEXT, dataHora TEXT, observacoes TEXT, FOREIGN KEY(petId) REFERENCES pets(id) ON DELETE CASCADE)''');
      }
    )
  }

  // métodos CRUD simplificados
  // inserir pet no bd
  Future<int> insert(Pet pet) async => (await database).insert("pets", pet.toMap());

  // listar pets
  Future<List<Pet>> getPets() async{
    final List<Map<String,dynamic>> maps = await (await database).query("pets", orderBy: "nome ASC");
    return List.generate(maps.length, (e) => Pet.fromMap(maps [e]));
  }

  // insert consulta
  Future<int> insertConsulta(Consulta c) async => (await database).insert("consultas", c.toMap());

  // get consultas por pet
  Future<List<Consulta>> getConsultaPorPet(int petId) async {
    final List<Map<String,dynamic>> maps = await (await database).query("consultas", where: "petId = ?", whereArgs: [petId], orderBy: "dataHora DESC");
    return List.generate(maps.length, (e) => Consulta.fromMap(maps [e]));
  }

  
}