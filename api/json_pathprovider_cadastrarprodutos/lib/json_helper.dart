// lógica de persistência de dados
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class JsonHelper {
  // Métodos static
  static Future<File> _getArquivo() async{
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados_produto.json");
  }

  static Future<Map<String, dynamic>> lerDados() async{
    try{
      final arquivo = await _getArquivo(); 
      if(await arquivo.exists()){
        String conteudo = await arquivo.readAsString();
        return json.decode(conteudo);
      }
    } catch(e){
      print("Erro ao ler o arquivo: $e");
    }
    return {}; 
  }

  static Future<void> salvarDados(Map<String, dynamic> dados) async{
    final arquivo = await _getArquivo(); 
    String jsonString = json.encode(dados); 
    await arquivo.writeAsString(jsonString); 
  }
}