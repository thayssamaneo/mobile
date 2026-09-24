import 'package:fiscalizacao_somativa/services/banco_dados_helper.dart';
import 'package:flutter/material.dart';
import '../models/registro_model.dart';
import '../services/servico_permissoes.dart';
import '../services/servico_localizacao.dart';
import '../services/servico_midia.dart';
import '../services/servico_feedback.dart';
import '../services/servico_utilitarios.dart';

class RegistroController extends ChangeNotifier {
  final BancoDadosHelper _bancoHelper = BancoDadosHelper.instancia;

  List<RegistroModel> _listaRegistros = [];
  bool _estaCarregando = false;
  String? _caminhoFotoAtual;
  double? _latitudeAtual;
  double? _longitudeAtual;
  String? _dataHoraAtual;
  String? _mensagemErro;

  // Getters para expor o estado para as Views
  List<RegistroModel> get listaRegistros => _listaRegistros;
  bool get estaCarregando => _estaCarregando;
  String? get caminhoFotoAtual => _caminhoFotoAtual;
  double? get latitudeAtual => _latitudeAtual;
  double? get longitudeAtual => _longitudeAtual;
  String? get dataHoraAtual => _dataHoraAtual;
  String? get mensagemErro => _mensagemErro;
  bool get formularioValido =>
      _caminhoFotoAtual != null &&
      _latitudeAtual != null &&
      _longitudeAtual != null;

  // Carrega a lista completa de registros armazenados no banco
  Future<void> carregarRegistros() async {
    _definirCarregando(true);
    try {
      _listaRegistros = await _bancoHelper.obterTodosRegistros();
      _mensagemErro = null;
    } catch (e) {
      _mensagemErro = 'Erro ao carregar registros: $e';
    } finally {
      _definirCarregando(false);
    }
  }

  // Captura uma nova foto pela câmera e atualiza o estado
  Future<bool> capturarFoto() async {
    final permissao = await ServicoPermissoes.solicitarPermissaoCamera();
    if (!permissao) {
      _mensagemErro = 'Permissão de câmera negada.';
      notifyListeners();
      return false;
    }

    final caminho = await ServicoMidia.capturarFotoCamera();
    if (caminho == null) return false;

    _caminhoFotoAtual = caminho;
    _dataHoraAtual = ServicoUtilitarios.formatarDataHora(DateTime.now());
    await obterLocalizacaoAtual();
    notifyListeners();
    return true;
  }

  // Obtém a posição geográfica atual do dispositivo via GPS
  Future<bool> obterLocalizacaoAtual() async {
    final permissao = await ServicoPermissoes.solicitarPermissaoLocalizacao();
    if (!permissao) {
      _mensagemErro = 'Permissão de localização negada.';
      notifyListeners();
      return false;
    }

    final posicao = await ServicoLocalizacao.obterPosicaoAtual();
    if (posicao == null) {
      _mensagemErro = 'Não foi possível obter a localização. Verifique o GPS.';
      notifyListeners();
      return false;
    }

    _latitudeAtual = posicao.latitude;
    _longitudeAtual = posicao.longitude;
    _dataHoraAtual ??= ServicoUtilitarios.formatarDataHora(DateTime.now());
    notifyListeners();
    return true;
  }

  // Salva o registro completo no banco de dados
  Future<bool> salvarRegistro(String observacao) async {
    if (!formularioValido) {
      _mensagemErro = 'Capture uma foto e obtenha a localização primeiro.';
      notifyListeners();
      return false;
    }

    _definirCarregando(true);
    try {
      final novoRegistro = _criarModeloRegistro(observacao);
      await _bancoHelper.inserirRegistro(novoRegistro);
      await ServicoFeedback.emitirSomConfirmacao();
      await carregarRegistros();
      limparFormulario();
      return true;
    } catch (e) {
      _mensagemErro = 'Erro ao salvar registro: $e';
      return false;
    } finally {
      _definirCarregando(false);
    }
  }

  // Cria o obj
  RegistroModel _criarModeloRegistro(String observacao) {
    return RegistroModel(
      dataHora: _dataHoraAtual ?? ServicoUtilitarios.formatarDataHora(DateTime.now()),
      caminhoDaFoto: _caminhoFotoAtual!,
      latitude: _latitudeAtual!,
      longitude: _longitudeAtual!,
      observacao: observacao.trim(),
    );
  }

  // Exclui um registro do banco e remove o arquivo de imagem associado
  Future<bool> excluirRegistro(int id, String caminhoFoto) async {
    _definirCarregando(true);
    try {
      await _bancoHelper.deletarRegistro(id);
      await ServicoMidia.removerArquivoFoto(caminhoFoto);
      await carregarRegistros();
      return true;
    } catch (e) {
      _mensagemErro = 'Erro ao excluir registro: $e';
      return false;
    } finally {
      _definirCarregando(false);
    }
  }

  // Limpa os campos do formulário
  void limparFormulario() {
    _caminhoFotoAtual = null;
    _latitudeAtual = null;
    _longitudeAtual = null;
    _dataHoraAtual = null;
    _mensagemErro = null;
    notifyListeners();
  }

  // Atualiza o estado de carregamento
  void _definirCarregando(bool valor) {
    _estaCarregando = valor;
    notifyListeners();
  }
}
