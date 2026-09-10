// aplicação de exemplo de código

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main(List<String> args){
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String mensagem = "Localização não obtida";

  void getLocation() async{
    // Solicitar a geolocalização quando for disparado o handle
    bool enable;
    LocationPermission permission;

    enable = await Geolocator.isLocationServiceEnabled(); // verificar se o service de localização está habilitado

    // se não estiver habilitado, você pede a permissão
    if (!enable) {
      mensagem = "Serviço de localização desabilitado";
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission(); // pedir permissão
      // se negar a permissão
      if (permission == LocationPermission.denied) {
        mensagem = "Acesso de localização não concedido pelo usuário";
      return;
      } 
    }
    
    // permissão liberada então
    Position position = await Geolocator.getCurrentPosition(); // pega a posição atual
    mensagem = "Latitude ${position.latitude}, Longitude ${position.longitude}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GPS - Localização"), centerTitle: true, backgroundColor: Colors.amberAccent,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mensagem),
            ElevatedButton(onPressed: ()async{
              setState(() {
                getLocation();
              });
            }, child: Text("Obter Localização")),
          ],
        ),
      ),
    );
  }
}