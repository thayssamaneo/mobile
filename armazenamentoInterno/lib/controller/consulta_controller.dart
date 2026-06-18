class ConsultaController{
  final _dbHelper = DatabaseHelper();

  Future<bool> salvarConsulta(Consulta c) async {
    await _dbHelper.insertConsulta(c);
    return true;
  }
  Future<List<Consulta>> listarConsultas(int petId) async => await _dbHelper.getConsultaPorPet(petId);
}