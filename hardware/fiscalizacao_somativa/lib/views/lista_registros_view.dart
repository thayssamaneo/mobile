import 'package:flutter/material.dart';
import '../controllers/registro_controller.dart';
import '../models/registro_model.dart';
import '../widgets/item_registro_card.dart';
import 'cadastro_registro_view.dart';
import 'detalhes_registro_view.dart';

class ListaRegistrosView extends StatefulWidget {
  final RegistroController controller;

  const ListaRegistrosView({super.key, required this.controller});

  @override
  State<ListaRegistrosView> createState() => _ListaRegistrosViewState();
}

class _ListaRegistrosViewState extends State<ListaRegistrosView> {
  @override
  void initState() {
    super.initState();
    widget.controller.carregarRegistros();
  }

  // Navega para a tela de cadastro de novo registro
  void _abrirCadastro() {
    widget.controller.limparFormulario();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CadastroRegistroView(controller: widget.controller),
      ),
    );
  }

  // Navega para a tela de detalhes do item selecionado
  void _abrirDetalhes(RegistroModel registro) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetalhesRegistroView(
          registro: registro,
          controller: widget.controller,
        ),
      ),
    );
  }

  // Solicita exclusão com confirmação visual
  Future<void> _excluirRegistro(RegistroModel registro) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir'),
        content: const Text('Deseja excluir este registro?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      await widget.controller.excluirRegistro(
        registro.id!,
        registro.caminhoDaFoto,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SENAI CheckIn'),
        backgroundColor: const Color(0xFFC4161C),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) => _construirConteudo(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFC4161C),
        foregroundColor: Colors.white,
        onPressed: _abrirCadastro,
        icon: const Icon(Icons.add_a_photo),
        label: const Text('Novo CheckIn'),
      ),
    );
  }

  // Constrói o indicador de progresso, vazio ou a lista
  Widget _construirConteudo() {
    if (widget.controller.estaCarregando && widget.controller.listaRegistros.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.controller.listaRegistros.isEmpty) {
      return _construirEstadoVazio();
    }

    return RefreshIndicator(
      onRefresh: widget.controller.carregarRegistros,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: widget.controller.listaRegistros.length,
        itemBuilder: (context, index) {
          final registro = widget.controller.listaRegistros[index];
          return ItemRegistroCard(
            registro: registro,
            aoTocar: () => _abrirDetalhes(registro),
            aoExcluir: () => _excluirRegistro(registro),
          );
        },
      ),
    );
  }

  // Constrói a tela quando não há registros cadastrados
  Widget _construirEstadoVazio() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.assignment_outlined, size: 70, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Nenhum registro encontrado',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 8),
            Text(
              'Toque no botão abaixo para capturar sua presença com foto e coordenadas GPS.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
