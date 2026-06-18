import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sa_petshop_sqlite/controller/pet_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final PetController _controller = PetController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PetShop - Lista de Pets"), backgroundcolor: Colors.deepOrange, centertitle:true),
      body: FutureBuilder<List<Pet>>(
        future: _controller.listarTodos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final pets = snapshot.data!;
          return ListView.builder(
            itemCount: pets.length,
            itemBuilder: (context, i) => ListTile(
              leading: Icon(Icons.pets),
              title: Text(pets[i].nome),
              subtitle: Text(pets[i].raca),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => PetDetailScreen(pet: pets[i]))).then((value) => setState(() {})),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => AddPetScreen())).then((value) => setState(() {})),
      ),
    );
  }
}