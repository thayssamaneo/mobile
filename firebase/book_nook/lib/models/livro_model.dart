// Enumeração que representa o status atual de leitura da obra
enum StatusLeitura {
  queroLer,
  lendo,
  lidos;

  // Retorna o rótulo amigável para exibição na interface
  String obterRotulo() {
    switch (this) {
      case StatusLeitura.queroLer:
        return 'Quero Ler';
      case StatusLeitura.lendo:
        return 'Lendo';
      case StatusLeitura.lidos:
        return 'Lidos';
    }
  }

  // Converte texto salvo em Firestore para o enum correspondente
  static StatusLeitura deTexto(String? texto) {
    switch (texto?.toLowerCase()) {
      case 'lendo':
        return StatusLeitura.lendo;
      case 'lidos':
        return StatusLeitura.lidos;
      default:
        return StatusLeitura.queroLer;
    }
  }
}

// Modelo de dados de um Livro no aplicativo Book Nook
class Livro {
  final String id;
  final String titulo;
  final List<String> autores;
  final String? capaUrl;
  final int? numeroPaginas;
  final String? idioma;
  final String? formatoEbook;
  final StatusLeitura status;
  final DateTime? dataCriacao;

  // Construtor principal da entidade Livro
  const Livro({
    required this.id,
    required this.titulo,
    this.autores = const [],
    this.capaUrl,
    this.numeroPaginas,
    this.idioma,
    this.formatoEbook,
    this.status = StatusLeitura.queroLer,
    this.dataCriacao,
  });

  // Converte a entidade Livro em um mapa para salvar no Cloud Firestore
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'autores': autores,
      'capaUrl': capaUrl,
      'numeroPaginas': numeroPaginas,
      'idioma': idioma,
      'formatoEbook': formatoEbook,
      'status': status.name,
      'dataCriacao': (dataCriacao ?? DateTime.now()).toIso8601String(),
    };
  }

  // Cria uma instância de Livro a partir de um documento do Cloud Firestore
  factory Livro.fromMap(Map<String, dynamic> mapa, String id) {
    return Livro(
      id: id,
      titulo: mapa['titulo'] as String? ?? 'Sem título',
      autores: (mapa['autores'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          [],
      capaUrl: mapa['capaUrl'] as String?,
      numeroPaginas: mapa['numeroPaginas'] as int?,
      idioma: mapa['idioma'] as String?,
      formatoEbook: mapa['formatoEbook'] as String?,
      status: StatusLeitura.deTexto(mapa['status'] as String?),
      dataCriacao: mapa['dataCriacao'] != null
          ? DateTime.tryParse(mapa['dataCriacao'].toString())
          : null,
    );
  }

  // Cria uma instância de Livro a partir da resposta da API OpenLibrary
  factory Livro.fromOpenLibrary(Map<String, dynamic> json) {
    final key = json['key'] as String? ?? DateTime.now().microsecondsSinceEpoch.toString();
    final capaId = json['cover_i'];
    final autoresJson = json['author_name'] as List<dynamic>?;
    final idiomasJson = json['language'] as List<dynamic>?;

    return Livro(
      id: key.replaceAll('/works/', ''),
      titulo: json['title'] as String? ?? 'Sem título',
      autores: autoresJson?.map((e) => e.toString()).toList() ?? ['Autor desconhecido'],
      capaUrl: capaId != null
          ? 'https://covers.openlibrary.org/b/id/$capaId-M.jpg'
          : null,
      numeroPaginas: json['number_of_pages_median'] as int?,
      idioma: idiomasJson?.isNotEmpty == true ? idiomasJson!.first.toString() : 'por',
      formatoEbook: json['ebook_access'] as String?,
      status: StatusLeitura.queroLer,
    );
  }

  // Cria uma cópia do livro com propriedades atualizadas
  Livro copyWith({
    String? id,
    String? titulo,
    List<String>? autores,
    String? capaUrl,
    int? numeroPaginas,
    String? idioma,
    String? formatoEbook,
    StatusLeitura? status,
    DateTime? dataCriacao,
  }) {
    return Livro(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      autores: autores ?? this.autores,
      capaUrl: capaUrl ?? this.capaUrl,
      numeroPaginas: numeroPaginas ?? this.numeroPaginas,
      idioma: idioma ?? this.idioma,
      formatoEbook: formatoEbook ?? this.formatoEbook,
      status: status ?? this.status,
      dataCriacao: dataCriacao ?? this.dataCriacao,
    );
  }
}
