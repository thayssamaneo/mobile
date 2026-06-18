import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Controle Financeiro", style: TextStyle(color: Colors.white),), backgroundColor: Color(0xFF415A77), centerTitle: true,),
      body: FutureBuilder(future: future, builder: builder),
    );
  }
}