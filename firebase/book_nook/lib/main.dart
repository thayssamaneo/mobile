import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'controllers/auth_controller.dart';
import 'controllers/livro_controller.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'views/login_view.dart';
import 'views/main_navigation_view.dart';

// Ponto de entrada principal do aplicativo Book Nook
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _inicializarFirebase();
  runApp(const BookNookApp());
}

// Inicializa o serviço Firebase de maneira segura
Future<void> _inicializarFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Permite que o app inicie mesmo em plataformas sem o arquivo nativo
    debugPrint('Aviso de inicialização do Firebase: $e');
  }
}

// Widget raiz que orquestra temas e controladores da aplicação
class BookNookApp extends StatefulWidget {
  const BookNookApp({super.key});

  @override
  State<BookNookApp> createState() => _BookNookAppState();
}

class _BookNookAppState extends State<BookNookApp> {
  late final AuthController _authController;
  late final LivroController _livroController;

  @override
  void initState() {
    super.initState();
    _authController = AuthController();
    _livroController = LivroController();
  }

  @override
  void dispose() {
    _authController.dispose();
    _livroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Nook',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.obterTemaClaro(),
      home: _construirTelaRaiz(),
    );
  }

  // Define a tela inicial com base no estado de autenticação
  Widget _construirTelaRaiz() {
    return ListenableBuilder(
      listenable: _authController,
      builder: (context, _) {
        if (_authController.estaAutenticado) {
          return MainNavigationView(
            authController: _authController,
            livroController: _livroController,
          );
        }
        return LoginView(authController: _authController);
      },
    );
  }
}
