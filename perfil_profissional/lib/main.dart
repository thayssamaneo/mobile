import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          leading: Transform.translate(
            offset: const Offset(0,-7),
            child: Icon(
              Icons.arrow_circle_left,
              size: 39.0,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            Transform.translate(
              offset: const Offset(-10, -7), 
              child: Icon(
                Icons.share,
                size: 39.0,
                color: Colors.white,
              ),
            ),
            Transform.translate(
              offset: const Offset(-10, -7), 
              child: Icon(
                Icons.settings,
                size: 39.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Container( 
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network('https://media.istockphoto.com/id/1495088043/pt/vetorial/user-profile-icon-avatar-or-person-icon-profile-picture-portrait-symbol-default-portrait.jpg?s=612x612&w=0&k=20&c=S7d8ImMSfoLBMCaEJOffTVua003OAl2xUnzOsuKIwek=',
                width: 130,
                height: 130,),
                Text("NOME",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut gravida sapien non ex bibendum consequat. Sed imperdiet, dolor sit amet posuere venenatis, enim sem feugiat nisi, nec convallis velit neque convallis elit. In ullamcorper, turpis non finibus tempus, magna nulla aliquet neque, et eleifend augue lectus at elit.", style: TextStyle(fontSize: 11),),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.visibility, color: Colors.white, size: 39.0,),
                          Text("3 Mil", style: TextStyle(color: Colors.white)),
                        ],
                      ), 
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.group, color: Colors.white, size: 39.0,),
                          Text("5 Mil", style: TextStyle(color: Colors.white)),
                        ],
                      ), 
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.public, color: Colors.white, size: 39.0,),
                          Text("2 Mil", style: TextStyle(color: Colors.white)),
                        ],
                      ), 
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text("Atributos",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                Container(
                  width: 350,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurpleAccent,
                  ),
                  child: Padding(padding: EdgeInsetsGeometry.all(5),
                    child: Column(
                      children: [
                        Text("Habilidades: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut gravida sapien non ex", style: TextStyle(color: Colors.white, fontSize: 12, )),
                        Text("Localização: Sed imperdiet, dolor sit amet posuere venenatis, enim sem feugiat nisi, nec convallis velit.", style: TextStyle(color: Colors.white, fontSize: 12)),
                        Text("Empresa: convallis elit. In ullamcorper, turpis non finibus tempus, magna nulla aliquet neque, et. ", style: TextStyle(color: Colors.white, fontSize: 12)),
                        Text("Trabalhos anteriores: augue lectus at elit. Sed eget commodo mauris, vitae interdum magna. Nam.", style: TextStyle(color: Colors.white, fontSize: 12)),
                        Text("Preferências: dictum metus mattis sed. Donec ornare risus sed suscipit dapibus. Phasellus.", style: TextStyle(color: Colors.white, fontSize: 12)),
                      ]
                    ),
                  )
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("I", style: TextStyle(color: Colors.white),)
                        ],
                      ), 
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("F", style: TextStyle(color: Colors.white),)
                        ],
                      ), 
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("L", style: TextStyle(color: Colors.white),)
                        ],
                      ), 
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.deepPurpleAccent,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.arrow_back, color: Colors.white,), label: "Buscar"),
            BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.white,), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.white,), label: "Perfil"),        
          ]),
      ),
    );
  }
}
