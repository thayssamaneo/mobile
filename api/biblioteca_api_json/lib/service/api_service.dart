// classe para estabelecer conexão com a api
// classe estática --> sem instancia de objetos, não precisa criar um obj para chamar a classe
// método singletown --> só instancia 1 obj por vez, em alguns casos é melhor que o static (quando tem muitas requisições simultâneas)
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.87.38.139:3033"; // URL da api -> trocar localhost pelo ip da máquina

  // obs: declaração de atributos e métodos usa lowerCamelCase
  // obs: declaração de classes usa UpperCamelCase

  // método de classe para acessar os endpoints da api
  // GET (ALL)
  static Future<List<dynamic>> getList(String path) async{
    // no dart precisa converter string em url => uri.parse faz isso :)
    final res = await http.get(Uri.parse("$baseUrl/$path"));
    if(res.statusCode == 200){
      return jsonDecode(res.body);
    }
    throw Exception("Falha de conexão com a API $path");
  }

  // GET (ONE)
  static Future<Map<String,dynamic>> getOne(String path, String id) async{
    final res = await http.get(Uri.parse("$baseUrl/$path/$id"));
    if(res.statusCode == 200){
      return jsonDecode(res.body);
    }
    throw Exception("Falha de conexão com a API $path");
  }

  // POST
  static Future<Map<String, dynamic>> post(String path, Map<String,dynamic> body) async{
    final res = await http.post(Uri.parse("$baseUrl/$path"), body: jsonEncode(body));
    if(res.statusCode == 201){
      return jsonDecode(res.body);
    }
    throw Exception("Falha de conexão com a API $path");
  }

  // PUT
  static Future<Map<String, dynamic>> put(String path, Map<String, dynamic> body, String id) async{
    final res = await http.put(Uri.parse("$baseUrl/$path"), body: jsonEncode(body));
    if(res.statusCode == 200){
      return jsonDecode(res.body);
    }
    throw Exception("Falha de conexão com a API $path");
  }

  // DELETE
  static Future<void> delete(String path, String id) async{
    final res = await http.delete(Uri.parse("$baseUrl/$path/$id"));
  if(res.statusCode != 200) throw Exception("Falha ao deletar de $path");
  }
}