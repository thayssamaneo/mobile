import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  static const chave = "appid=90290436d34bb91b4d852afe49197129";

  // método para trazer a temperatura do lugar usando as coordenadas
  Future<Map<String, dynamic>> getClimaLocation(Position position) async{
    final res = await http.get(Uri.parse("${baseUrl}lat=${position.latitude}&lon=${position.longitude}&appid=$chave"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else{
      throw Exception("Falha de conexão com a api!");
    }
  }
}