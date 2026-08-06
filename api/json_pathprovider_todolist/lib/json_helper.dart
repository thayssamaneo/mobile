// lógica de persistência de dados
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class JsonHelper {
  // Métodos static => métodos da classe e não do obj (para usar  método não precisa instanciar obj)
  // 1. Método obter arquivo JSON (static)
  static Future<File> _getArquivo() async{
    final diretorio = await getApplicationDocumentsDirectory(); // buscando os arquivos do aplicativo
    return File("${diretorio.path}/dados_usuario.json"); // retorna o caminho do arquivo json
    // se arquivo não existir, ele será criado automaticamente
  }

  // 2. Ler todos os dados do JSON (Converter JSON em map)
  static Future<Map<String, dynamic>> lerDados() async{
    try{
      final arquivo = await _getArquivo(); // busco o arquivo
      // verifico se o arquivo existe
      if(await arquivo.exists()){
        String conteudo = await arquivo.readAsString();
        return json.decode(conteudo);
      }
    } catch(e){
      print("Erro ao ler o arquivo: $e");
    }
    return {}; // Retorna um Map vazio se não existir ou der erro
  }

  //  3. Salvar os dados no arquivo JSON
  static Future<void> salvarDados(Map<String, dynamic> dados) async{
    final arquivo = await _getArquivo(); // pegando o local do arquivo
    String jsonString = json.encode(dados); // transformando MAP em JSON
    await arquivo.writeAsString(jsonString); // armazenando os dados no local
  }
}