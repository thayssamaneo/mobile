import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

// Tela de autenticação e cadastro de novos leitores
class LoginView extends StatefulWidget {
  final AuthController authController;

  const LoginView({super.key, required this.authController});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _nomeController = TextEditingController();
  bool _modoCadastro = false;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _construirLogotipo(),
                  const SizedBox(height: 32),
                  _construirCampos(),
                  const SizedBox(height: 20),
                  _construirBotaoAcao(),
                  const SizedBox(height: 16),
                  _construirAlternadorModo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Constrói o cabeçalho e logotipo do aplicativo
  Widget _construirLogotipo() {
    final tema = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: tema.colorScheme.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.menu_book_rounded, size: 48, color: tema.colorScheme.primary),
        ),
        const SizedBox(height: 16),
        const Text(
          'Book Nook',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -0.5),
        ),
        const SizedBox(height: 6),
        Text(
          'Sua estante de livros digital',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ],
    );
  }

  // Constrói os campos de entrada do formulário
  Widget _construirCampos() {
    return Column(
      children: [
        if (_modoCadastro) ...[
          _construirCampoNome(),
          const SizedBox(height: 14),
        ],
        _construirCampoEmail(),
        const SizedBox(height: 14),
        _construirCampoSenha(),
      ],
    );
  }

  // Campo de nome do leitor
  Widget _construirCampoNome() {
    return TextFormField(
      controller: _nomeController,
      decoration: const InputDecoration(
        labelText: 'Nome completo',
        prefixIcon: Icon(Icons.person_outline),
      ),
      validator: (valor) =>
          valor == null || valor.isEmpty ? 'Informe seu nome' : null,
    );
  }

  // Campo de e-mail com validação básica
  Widget _construirCampoEmail() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'E-mail',
        prefixIcon: Icon(Icons.email_outlined),
      ),
      validator: (valor) =>
          valor == null || !valor.contains('@') ? 'E-mail inválido' : null,
    );
  }

  // Campo de senha
  Widget _construirCampoSenha() {
    return TextFormField(
      controller: _senhaController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Senha',
        prefixIcon: Icon(Icons.lock_outline),
      ),
      validator: (valor) =>
          valor == null || valor.length < 6 ? 'Mínimo de 6 caracteres' : null,
    );
  }

  // Botão de submissão do formulário
  Widget _construirBotaoAcao() {
    return ListenableBuilder(
      listenable: widget.authController,
      builder: (context, _) {
        if (widget.authController.carregando) {
          return const CircularProgressIndicator();
        }
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _aoSubmeterFormulario,
            child: Text(_modoCadastro ? 'Criar Conta' : 'Entrar'),
          ),
        );
      },
    );
  }

  // Alternador entre Login e Cadastro
  Widget _construirAlternadorModo() {
    return TextButton(
      onPressed: () {
        setState(() => _modoCadastro = !_modoCadastro);
        widget.authController.limparErro();
      },
      child: Text(
        _modoCadastro
            ? 'Já possui uma conta? Faça Login'
            : 'Ainda não tem conta? Cadastre-se',
      ),
    );
  }

  // Trata o envio do formulário de autenticação
  Future<void> _aoSubmeterFormulario() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text;
    final senha = _senhaController.text;
    final nome = _nomeController.text;

    final sucesso = _modoCadastro
        ? await widget.authController.realizarCadastro(email, senha, nome)
        : await widget.authController.realizarLogin(email, senha);

    _tratarRetornoAuth(sucesso);
  }

  // Exibe feedback visual ao usuário em caso de erro
  void _tratarRetornoAuth(bool sucesso) {
    if (!sucesso && mounted && widget.authController.mensagemErro != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.authController.mensagemErro!),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
