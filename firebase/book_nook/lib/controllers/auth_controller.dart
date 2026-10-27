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
      _mensagemErro = _formatarErro(e.toString());
      return false;
    } finally {
      _definirCarregamento(false);
    }
  }

  // Encerra a sessão ativa do usuário
  Future<void> encerrarSessao() async {
    await _authService.logout();
    _usuarioAtual = null;
    notifyListeners();
  }

  // Atualiza a flag de carregamento e notifica a interface
  void _definirCarregamento(bool valor) {
    _carregando = valor;
    notifyListeners();
  }

  // Formata mensagens de erro para o leitor em português
  String _formatarErro(String erroOriginal) {
    if (erroOriginal.contains('user-not-found')) return 'Usuário não encontrado.';
    if (erroOriginal.contains('wrong-password')) return 'Senha incorreta.';
    if (erroOriginal.contains('email-already-in-use')) return 'E-mail já cadastrado.';
    if (erroOriginal.contains('weak-password')) return 'A senha deve ter ao menos 6 dígitos.';
    return 'Falha na operação. Verifique seus dados.';
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
