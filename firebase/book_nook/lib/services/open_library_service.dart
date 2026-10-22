import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/livro_model.dart';

// Serviço encarregado da comunicação com a API OpenLibrary
class OpenLibraryService {
  final http.Client _client;

  // Construtor com injeção de dependência opcional para testes
  OpenLibraryService({http.Client? client}) : _client = client ?? http.Client();

  // Executa busca de livros por título ou autor filtrando por língua portuguesa
  Future<List<Livro>> buscarLivros(String termo) async {
    if (termo.trim().isEmpty) return [];

    final url = _construirUriBusca(termo);
    try {
      final resposta = await _client.get(url).timeout(const Duration(seconds: 12));
      return _processarRespostaBusca(resposta);
    } catch (e) {
      // Retorna lista vazia em caso de falha de conexão ou timeout
      return [];
    }
  }

  // Constrói o URI formatado conforme o endpoint documentado
  Uri _construirUriBusca(String termo) {
    final query = Uri.encodeComponent(termo.trim());
    return Uri.parse(
      'https://openlibrary.org/search.json?q=$query+language%3Apor&limit=25',
    );
  }

  // Converte o corpo da resposta HTTP em lista tipada de livros
  List<Livro> _processarRespostaBusca(http.Response resposta) {
    if (resposta.statusCode != 200) return [];

    final dados = jsonDecode(utf8.decode(resposta.bodyBytes)) as Map<String, dynamic>;
    final docs = dados['docs'] as List<dynamic>? ?? [];

    return docs
        .whereType<Map<String, dynamic>>()
        .map((item) => Livro.fromOpenLibrary(item))
        .toList();
  }
}
