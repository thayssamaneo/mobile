import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_exercicio/api_service.dart';

void main(List<String> args){
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String msg = "teste";
  String clima = "clima";
  late Position position;

  final ApiService apiService = ApiService();

  // método pra pegar a localização
  void getLocation() async{
    bool enable;
    LocationPermission permission;

    //verificar se o serviço de localização esta habilitado
    enable = await Geolocator. isLocationServiceEnabled();
    // Se a permissão não estiver habilitada
    if(!enable){
      msg = "Serviço de Localização desabilitado";
    }
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission(); // vou solicitar a permissão
      if(permission == LocationPermission.denied){
        msg = "Acesso a Localização não Permitido pelo Usuário";
      }
    //permissão liberada=
    }    
    //pegando a posição atual
    position = await Geolocator.getCurrentPosition();
    msg = "Latitude ${position.latitude}, Longitude: ${position.longitude}";
  }

  // método para trazer o clima
  void getClima() async{
    getLocation();

    try {
      final climaAtual = await apiService.getClimaLocation(position);
      if (climaAtual != null){
        clima = "${climaAtual["name"]} -- ${climaAtual["main"]["temp"] - 273}°";
      }
    } catch (e) {
      clima = e.toString();
    }
    
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GPS - Localização"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(msg),
            ElevatedButton(onPressed: ()async{
              setState(() {
                getClima();
              });
            }, child: Text("Obter Localização"))
          ],
        ),
      ),
    );
  }
}