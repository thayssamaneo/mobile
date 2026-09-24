import 'package:flutter/material.dart';
import '../controllers/registro_controller.dart';
import '../services/servico_feedback.dart';
import '../services/servico_permissoes.dart';
import '../widgets/cartao_foto_preview.dart';
import '../widgets/cartao_coordenadas.dart';

// Tela de cadastro de novo registro com captura de foto e GPS.
class CadastroRegistroView extends StatefulWidget {
  final RegistroController controller;

  const CadastroRegistroView({super.key, required this.controller});

  @override
  State<CadastroRegistroView> createState() => _CadastroRegistroViewState();
}

class _CadastroRegistroViewState extends State<CadastroRegistroView> {
  final TextEditingController _observacaoController = TextEditingController();

  @override
  void dispose() {
    _observacaoController.dispose();
    super.dispose();
  }

  // Tira foto e atualiza coordenadas
  Future<void> _capturarFoto() async {
    final sucesso = await widget.controller.capturarFoto();
    if (!sucesso && mounted && widget.controller.mensagemErro != null) {
      _tratarErroPermissao(widget.controller.mensagemErro!);
    }
  }

  // Atualiza a posição de GPS manualmente
  Future<void> _atualizarGps() async {
    final sucesso = await widget.controller.obterLocalizacaoAtual();
    if (!sucesso && mounted && widget.controller.mensagemErro != null) {
      _tratarErroPermissao(widget.controller.mensagemErro!);
    }
  }

  // Salva o registro e retorna para a lista em caso de sucesso
  Future<void> _salvarRegistro() async {
    final sucesso = await widget.controller.salvarRegistro(
      _observacaoController.text,
    );
    if (!mounted) return;

    if (sucesso) {
      ServicoFeedback.exibirMensagemSucesso(
        context,
        'Registro salvo com sucesso!',
      );
      Navigator.pop(context);
    } else if (widget.controller.mensagemErro != null) {
      ServicoFeedback.exibirMensagemAviso(
        context,
        widget.controller.mensagemErro!,
      );
    }
  }

  // Exibe diálogo de orientação para permissões negadas
  void _tratarErroPermissao(String mensagem) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Permissão Necessária'),
        content: Text('$mensagem Habilite o acesso nas configurações do aplicativo.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ServicoPermissoes.abrirConfiguracoesDoApp();
            },
            child: const Text('Abrir Configurações'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Registro'),
        backgroundColor: const Color(0xFFC4161C),
        foregroundColor: Colors.white,
      ),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) => _construirCorpo(),
      ),
    );
  }

  // Constrói o corpo do formulário
  Widget _construirCorpo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CartaoFotoPreview(
            caminhoFoto: widget.controller.caminhoFotoAtual,
            aoPressionarCaptura: _capturarFoto,
          ),
          const SizedBox(height: 16),
          CartaoCoordenadas(
            latitude: widget.controller.latitudeAtual,
            longitude: widget.controller.longitudeAtual,
            dataHora: widget.controller.dataHoraAtual,
            aoPressionarAtualizar: _atualizarGps,
          ),
          const SizedBox(height: 16),
          _construirCampoObservacao(),
          const SizedBox(height: 24),
          _construirBotaoSalvar(),
        ],
      ),
    );
  }

  // Constrói o campo de texto para observação
  Widget _construirCampoObservacao() {
    return TextField(
      controller: _observacaoController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Observação (opcional)',
        hintText: 'Digite detalhes sobre a visita ou fiscalização...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  // Constrói o botão de salvar registro com estado de carregamento
  Widget _construirBotaoSalvar() {
    if (widget.controller.estaCarregando) {
      return const Center(child: CircularProgressIndicator());
    }

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC4161C),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: _salvarRegistro,
      icon: const Icon(Icons.save_rounded),
      label: const Text('Salvar Registro', style: TextStyle(fontSize: 16)),
    );
  }
}
