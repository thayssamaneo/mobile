import 'package:firebase_auth/firebase_auth.dart';
import '../models/usuario_model.dart';

// Serviço encarregado de gerenciar a autenticação via Firebase Auth
class AuthService {
  final FirebaseAuth _auth;

  // Construtor que recebe a instância do FirebaseAuth
  AuthService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  // Stream que monitora alterações de estado de autenticação
  Stream<Usuario?> get usuarioStream {
    return _auth.authStateChanges().map(_converterFirebaseUser);
  }

  // Retorna o usuário atualmente autenticado
  Usuario? get usuarioAtual {
    return _converterFirebaseUser(_auth.currentUser);
  }

  // Realiza login com e-mail e senha
  Future<Usuario?> login(String email, String senha) async {
    final credencial = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: senha,
    );
    return _converterFirebaseUser(credencial.user);
  }

  // Cria um novo cadastro com e-mail e senha
  Future<Usuario?> cadastrar(String email, String senha, String nome) async {
    final credencial = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: senha,
    );
    await credencial.user?.updateDisplayName(nome.trim());
    return _converterFirebaseUser(credencial.user);
  }

  // Encerra a sessão do usuário ativo
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Converte a entidade User do Firebase para a entidade de domínio Usuario
  Usuario? _converterFirebaseUser(User? user) {
    if (user == null) return null;
    return Usuario(
      id: user.uid,
      email: user.email ?? '',
      nome: user.displayName ?? (user.email?.split('@').first ?? 'Leitor'),
    );
  }
}
