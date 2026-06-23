import 'package:flutter/material.dart';
import '../controllers/financeiro_controller.dart';
import '../models/categoria_model.dart';
import 'cadastro_categoria_screen.dart';
import 'categoria_detalhes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FinanceiroController _controller = FinanceiroController();
  late Future<List<Categoria>> _futureCategorias;

  @override
  void initState() {
    super.initState();
    _atualizarCategorias();
  }

  void _atualizarCategorias() {
    setState(() {
      _futureCategorias = _controller.listarCategorias();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Controle financeiroiro",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF415A77),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<Categoria>>(
        future: _futureCategorias,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar os dados."));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Nenhuma categoria cadastrada.\nClique no '+' para começar."),
            );
          }

          final categorias = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: categorias.length,
            itemBuilder: (context, index) {
              final cat = categorias[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF415A77),
                    child: Icon(Icons.folder, color: Colors.white),
                  ),
                  title: Text(cat.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(cat.descricao, maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoriaDetalhesScreen(categoria: cat),
                      ),
                    );
                    _atualizarCategorias(); // Recarrega se houver alterações
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF415A77),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final resultado = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CadastroCategoriaScreen()),
          );
          if (resultado == true) {
            _atualizarCategorias();
          }
        },
      ),
    );
  }
}