import 'dart:async';
import 'package:flutter/material.dart';
import '../models/estatisticas_model.dart';
import '../models/livro_model.dart';
import '../services/firestore_service.dart';
import '../services/open_library_service.dart';

// Controlador encarregado de gerenciar as estantes, buscas e estatísticas
class LivroController extends ChangeNotifier {
  final OpenLibraryService _openLibraryService;
  final FirestoreService _firestoreService;
  StreamSubscription<List<Livro>>? _inscricaoEstantes;

  List<Livro> _resultadosBusca = [];
  List<Livro> _livrosEstante = [];
  bool _buscando = false;
  String? _erroBusca;

  // Construtor que recebe os serviços do domínio
  LivroController({
    OpenLibraryService? openLibraryService,
    FirestoreService? firestoreService,
  })  : _openLibraryService = openLibraryService ?? OpenLibraryService(),
        _firestoreService = firestoreService ?? FirestoreService();

  // Getters de estado público
  List<Livro> get resultadosBusca => _resultadosBusca;
  List<Livro> get livrosEstante => _livrosEstante;
  bool get buscando => _buscando;
  String? get erroBusca => _erroBusca;

  // Calcula dinamicamente as estatísticas de leitura do usuário
  Estatisticas get estatisticas => Estatisticas.calcular(_livrosEstante);

  // Filtra as obras conforme o status da estante desejada
  List<Livro> obterLivrosPorStatus(StatusLeitura status) {
    return _livrosEstante.where((livro) => livro.status == status).toList();
  }

  // Pesquisa obras literárias na OpenLibrary com tratamento de estado
  Future<void> pesquisarObras(String termo) async {
    _buscando = true;
    _erroBusca = null;
    notifyListeners();

    try {
      _resultadosBusca = await _openLibraryService.buscarLivros(termo);
    } catch (e) {
      _erroBusca = 'Não foi possível carregar os livros. Tente novamente.';
    } finally {
      _buscando = false;
      notifyListeners();
    }
  }

  // Conecta o ouvinte em tempo real com as estantes no Cloud Firestore
  void iniciarMonitoramentoEstantes(String userId) {
    _inscricaoEstantes?.cancel();
    _inscricaoEstantes = _firestoreService.ouvirLivros(userId).listen(
      (livros) {
        _livrosEstante = livros;
        notifyListeners();
      },
      onError: (erro) {
        debugPrint('Aviso ao sincronizar estantes: $erro');
      },
    );
  }

  // Cancela o monitoramento ativo e limpa a lista da memória
  void limparEstantes() {
    _inscricaoEstantes?.cancel();
    _inscricaoEstantes = null;
    _livrosEstante = [];
    notifyListeners();
  }

  // Adiciona um livro a uma estante selecionada
  Future<void> salvarNaEstante(
    String userId,
    Livro livro,
    StatusLeitura status,
  ) async {
    final livroAtualizado = livro.copyWith(
      status: status,
      dataCriacao: DateTime.now(),
    );
    await _firestoreService.salvarLivro(userId, livroAtualizado);
  }

  // Atualiza a estante/status de leitura de uma obra existente
  Future<void> atualizarStatusLivro(
    String userId,
    String livroId,
    StatusLeitura novoStatus,
  ) async {
    await _firestoreService.atualizarStatus(userId, livroId, novoStatus);
  }

  // Remove definitivamente o livro da estante do usuário
  Future<void> excluirDaEstante(String userId, String livroId) async {
    await _firestoreService.excluirLivro(userId, livroId);
  }

  // Cancela assinaturas ao destruir a instância
  @override
  void dispose() {
    _inscricaoEstantes?.cancel();
    super.dispose();
  }
}
