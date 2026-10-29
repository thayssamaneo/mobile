import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'controllers/auth_controller.dart';
import 'controllers/livro_controller.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'views/login_view.dart';
import 'views/main_navigation_view.dart';

// Ponto de entrada principal do aplicativo Book Nook
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BookNookApp());
}

// Widget raiz que orquestra temas, inicialização e controladores
class BookNookApp extends StatefulWidget {
  const BookNookApp({super.key});

  @override
  State<BookNookApp> createState() => _BookNookAppState();
}

class _BookNookAppState extends State<BookNookApp> {
  late final Future<FirebaseApp?> _inicializacaoFirebase;
  AuthController? _authController;
  LivroController? _livroController;

  @override
  void initState() {
    super.initState();
    _inicializacaoFirebase = _inicializarFirebase();
  }

  // Inicializa o Firebase e instancia os controladores
  Future<FirebaseApp?> _inicializarFirebase() async {
    try {
      final app = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _instanciarControladores();
      return app;
    } catch (e) {
      debugPrint('Aviso de inicialização do Firebase: $e');
      _instanciarControladores();
      return null;
    }
  }

  // Instancia os controladores de autenticação e livros
  void _instanciarControladores() {
    _authController = AuthController();
    _livroController = LivroController();
  }

  @override
  void dispose() {
    _authController?.dispose();
    _livroController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Nook',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.obterTemaClaro(),
      home: FutureBuilder<FirebaseApp?>(
        future: _inicializacaoFirebase,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _construirTelaCarregamento();
          }
          return _construirTelaRaiz();
        },
      ),
    );
  }

  // Constrói uma tela de carregamento suave
  Widget _construirTelaCarregamento() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // Define a tela inicial com base no estado de autenticação
  Widget _construirTelaRaiz() {
    final auth = _authController;
    final livro = _livroController;
    if (auth == null || livro == null) {
      return _construirTelaCarregamento();
    }
    return ListenableBuilder(
      listenable: auth,
      builder: (context, _) {
        if (auth.estaAutenticado) {
          return MainNavigationView(
            authController: auth,
            livroController: livro,
          );
        }
        return LoginView(authController: auth);
      },
    );
  }
}
