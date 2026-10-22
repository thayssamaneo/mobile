import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/livro_model.dart';

// Serviço encarregado da persistência das estantes no Cloud Firestore
class FirestoreService {
  final FirebaseFirestore _firestore;

  // Construtor que recebe a instância do FirebaseFirestore
  FirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Retorna a referência da coleção de livros de um usuário específico
  CollectionReference<Map<String, dynamic>> _colecaoLivros(String userId) {
    return _firestore.collection('usuarios').doc(userId).collection('livros');
  }

  // Salva ou sobrescreve uma obra na estante do usuário
  Future<void> salvarLivro(String userId, Livro livro) async {
    await _colecaoLivros(userId).doc(livro.id).set(livro.toMap());
  }

  // Atualiza apenas o status de leitura da obra
  Future<void> atualizarStatus(
    String userId,
    String livroId,
    StatusLeitura novoStatus,
  ) async {
    await _colecaoLivros(userId).doc(livroId).update({
      'status': novoStatus.name,
    });
  }

  // Remove permanentemente o registro do livro da estante
  Future<void> excluirLivro(String userId, String livroId) async {
    await _colecaoLivros(userId).doc(livroId).delete();
  }

  // Emite em tempo real a listagem atualizada de livros do usuário
  Stream<List<Livro>> ouvirLivros(String userId) {
    return _colecaoLivros(userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Livro.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }
}
