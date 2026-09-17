// exemplo de leitura de sensor de conexão

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(home: MyApp(),debugShowCheckedModeBanner: false,));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // texto da mensagem
  String _mensagem = "Verificando...";

  // objeto para ouvir as mudanças de conexão
  late StreamSubscription<List<ConnectivityResult>> _wifiObserver;

  // métodos
  // método para verificar a conexão
  void _checkConnection() async{
    //criar uma variável para receber as mudanças
    var _connectivityResult = (await Connectivity().checkConnectivity()) as ConnectivityResult;
    _updateConnectionStatus(_connectivityResult);
  }
  
  // método para atualizar as mudanças de conexão
  void _updateConnectionStatus(ConnectivityResult result){
    setState(() {
      switch (result) {
        case ConnectivityResult.wifi:
          _mensagem = "Conectado no wi-fi";
          break;
        case ConnectivityResult.mobile:
          _mensagem = "Conectado nos dados móveis";
          break;
        case ConnectivityResult.none:
          _mensagem = "Sem conexão com a internet";
          break;
        default:
          _mensagem = "Procurando conexão...";
          break;
      }
    });
  }

  // inicio
  @override
  void initState() {
    super.initState();
    // 1. checar conexão
    _checkConnection();
    // 2. Habilitar o stream para ouvir a mudança de conexão
    _wifiObserver = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results){
      // pega o resultado disponível e transmite para o update
      final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
      _updateConnectionStatus(result);
    });
  }

  // limpa a mémoria ao sair da tela
  @override
  void dispose() {
    super.dispose();
    _wifiObserver.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Status da conexão",), centerTitle: true, backgroundColor: Colors.pinkAccent,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              // icone vai mudar de acordo com a conexão
              _mensagem.contains("wi-fi") ? Icons.wifi :
              _mensagem.contains("dados") ? Icons.network_cell :
              Icons.wifi_off,
              size: 80,
              color: _mensagem.contains("Sem") ? Colors.red : Colors.green,
            ),
            SizedBox(height: 10,),
            Text("Status: $_mensagem"),
          ],
        ),
      ),
    );
  }
}