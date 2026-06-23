import 'package:flutter/material.dart';
import '../controllers/financeiro_controller.dart';
import '../models/categoria_model.dart';

class CadastroCategoriaScreen extends StatefulWidget {
  const CadastroCategoriaScreen({super.key});

  @override
  State<CadastroCategoriaScreen> createState() => _CadastroCategoriaScreenState();
}

class _CadastroCategoriaScreenState extends State<CadastroCategoriaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final FinanceiroController _financeiroController = FinanceiroController();

  void _salvarCategoria() async {
    if (_formKey.currentState!.validate()) {
      final novaCategoria = Categoria(
        nome: _nomeController.text.trim(),
        descricao: _descricaoController.text.trim(),
      );

      try {
        bool sucesso = await _financeiroController.inserirCategoria(novaCategoria);
        if (mounted) {
          if (sucesso) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Categoria cadastrada com sucesso!")),
            );
            Navigator.pop(context, true);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Erro: Uma categoria com este nome já existe.")),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao salvar: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova Categoria", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF415A77),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: "Nome da Categoria"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Por favor, insira o nome da categoria.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: "Descrição"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Por favor, insira uma descrição curta.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF415A77),
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: _salvarCategoria,
                child: const Text("Cadastrar", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}