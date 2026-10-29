import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../controllers/livro_controller.dart';
import 'busca_livros_view.dart';
import 'estantes_view.dart';
import 'estatisticas_view.dart';

// Tela principal com navegação por abas inferiores
class MainNavigationView extends StatefulWidget {
  final AuthController authController;
  final LivroController livroController;

  const MainNavigationView({
    super.key,
    required this.authController,
    required this.livroController,
  });

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  int _indiceAtual = 0;

  @override
  void initState() {
    super.initState();
    _iniciarEscutaEstantes();
  }

  // Conecta o ouvinte em tempo real com os livros do usuário logado
  void _iniciarEscutaEstantes() {
    final usuario = widget.authController.usuarioAtual;
    if (usuario != null) {
      widget.livroController.iniciarMonitoramentoEstantes(usuario.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = widget.authController.usuarioAtual?.id ?? '';
    final telas = [
      BuscaLivrosView(livroController: widget.livroController, userId: userId),
      EstantesView(livroController: widget.livroController, userId: userId),
      EstatisticasView(
        livroController: widget.livroController,
        authController: widget.authController,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _indiceAtual,
        children: telas,
      ),
      bottomNavigationBar: _construirBarraNavegacao(),
    );
  }

  // Barra de navegação inferior Material 3
  Widget _construirBarraNavegacao() {
    return NavigationBar(
      selectedIndex: _indiceAtual,
      onDestinationSelected: (idx) => setState(() => _indiceAtual = idx),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search),
          label: 'Descobrir',
        ),
        NavigationDestination(
          icon: Icon(Icons.collections_bookmark_outlined),
          selectedIcon: Icon(Icons.collections_bookmark),
          label: 'Estantes',
        ),
        NavigationDestination(
          icon: Icon(Icons.insights_outlined),
          selectedIcon: Icon(Icons.insights),
          label: 'Estatísticas',
        ),
      ],
    );
  }
}
