import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:lista_tarefas_firebase/screen/login_screen.dart';
import 'package:lista_tarefas_firebase/screen/tarefas_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // método de leitura de mudança de estado para lingugens POO
      builder: (context, snapshot){
        // se o snapshot tem dados armazenados significa que o usuário está logado
        if (snapshot.hasData) {
          return TarefasScreen();
        }
        // se não tiver dados do usuário armazenado
        return LoginScreen();
      });
  }
}