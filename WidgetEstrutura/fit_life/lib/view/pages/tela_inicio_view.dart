import 'package:flutter/material.dart';

class TelainicioView extends StatelessWidget{
  const TelainicioView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FitLife"), backgroundColor: Colors.blueAccent,centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(8),child: Image.network('https://media.extraguarapuava.com.br/2020/12/db570f53-exercicios-fisicos-1.jpg', width: 300, height: 420, fit: BoxFit.cover,),),
          SizedBox(height: 8,),
          Text('Seu Monitor de Saúde e Atividades Físicas', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          SizedBox(height: 8,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: (){
            Navigator.pushNamed(context, '/ativMenu');
          }, 
            child: Text("Começar")),
        ],
      ),
      )
    );
  }
}