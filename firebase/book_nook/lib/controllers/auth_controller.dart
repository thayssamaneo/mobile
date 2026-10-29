import 'dart:async';
import 'package:flutter/material.dart';
import '../models/usuario_model.dart';
import '../services/auth_service.dart';

// Controlador responsável pelo estado de autenticação e sessão do usuário
class AuthController extends ChangeNotifier {
  final AuthService _authService;
  StreamSubscription<Usuario?>? _inscricaoAuth;

  Usuario? _usuarioAtual;
  bool _carregando = false;
  String? _mensagemErro;

  // Construtor que inicializa a escuta das mudanças de sessão
  AuthController({AuthService? authService})
      : _authService = authService ?? AuthService() {
    _iniciarEscuta();
  }

  // Getters de estado público
  Usuario? get usuarioAtual => _usuarioAtual;
  bool get estaAutenticado => _usuarioAtual != null;
  bool get carregando => _carregando;
  String? get mensagemErro => _mensagemErro;

  // Inicia a escuta reativa das alterações de usuário
  void _iniciarEscuta() {
    _usuarioAtual = _authService.usuarioAtual;
    _inscricaoAuth = _authService.usuarioStream.listen((usuario) {
      _usuarioAtual = usuario;
      notifyListeners();
    });
  }

  // Realiza login e gerencia estados de carregamento e erro
  Future<bool> realizarLogin(String email, String senha) async {
    _definirCarregamento(true);
    try {
      _usuarioAtual = await _authService.login(email, senha);
      _mensagemErro = null;
      return true;
    } catch (e) {
      debugPrint('Erro de autenticação no login: $e');
      _mensagemErro = _formatarErro(e.toString());
      return false;
    } finally {
      _definirCarregamento(false);
    }
  }

  // Realiza o cadastro de um novo leitor
  Future<bool> realizarCadastro(String email, String senha, String nome) async {
    _definirCarregamento(true);
    try {
      _usuarioAtual = await _authService.cadastrar(email, senha, nome);
      _mensagemErro = null;
      return true;
    } catch (e) {
      debugPrint('Erro de autenticação no cadastro: $e');
      _mensagemErro = _formatarErro(e.toString());
      return false;
    } finally {
      _definirCarregamento(false);
    }
  }

  // Encerra a sessão ativa do usuário com segurança
  Future<void> encerrarSessao() async {
    try {
      await _authService.logout();
    } catch (e) {
      debugPrint('Aviso ao encerrar sessão: $e');
    } finally {
      _usuarioAtual = null;
      notifyListeners();
    }
  }

  // Atualiza a flag de carregamento e notifica a interface
  void _definirCarregamento(bool valor) {
    _carregando = valor;
    notifyListeners();
  }

  // Formata mensagens de erro para o leitor em português
  String _formatarErro(String erroOriginal) {
    if (erroOriginal.contains('operation-not-allowed')) {
      return 'Autenticação por e-mail desativada no Firebase Console.';
    }
    if (erroOriginal.contains('invalid-credential') ||
        erroOriginal.contains('wrong-password') ||
        erroOriginal.contains('user-not-found')) {
      return 'E-mail ou senha inválidos.';
    }
    if (erroOriginal.contains('email-already-in-use')) {
      return 'Este e-mail já está cadastrado.';
    }
    if (erroOriginal.contains('weak-password')) {
      return 'A senha deve ter no mínimo 6 caracteres.';
    }
    if (erroOriginal.contains('network-request-failed') ||
        erroOriginal.contains('TimeoutException')) {
      return 'Falha de conexão. Verifique o acesso à internet.';
    }
    return 'Falha na autenticação: verifique os dados informados.';
  }

  // Limpa mensagens de erro exibidas na interface
  void limparErro() {
    _mensagemErro = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _inscricaoAuth?.cancel();
    super.dispose();
  }
}
