// página de formulário
// tela com elementos de formulário
// textField
// checkbox
// radiobutton
// slider // barra de seleção
// switch --> botão de alternância
// dropdown --> menu suspenso

// form --> ajuda na validação de dados

import 'package:flutter/material.dart';
import 'package:intro_interacao/widgets/bnb.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // atributos
  String _nome = "";
  String _senha = "";
  String _email = "";
  String _confirmarSenha = "";
  bool _aceitarTermos = false; // switch dos termos
  String _sexo = "Feminino"; // radio
  double _idade = 18; //slider -> posição 18
  List<String> _interesses = []; // checkbox
  String _cidade = "Americana"; // dropdown -> escolha das cidades

  // esconder senha
  bool _obscureSenha = true;

  // chave global de validação do formulário
  final formKey = GlobalKey<FormState>(); // formulário só será enviado se a chave for validada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulário de cadastro"), backgroundColor: Colors.indigo,),
      body: Padding(
        padding: EdgeInsets.all(8),
        // adicionar elemento e fazer a verificação
        child: Form(
          key: formKey, // chave de validação para o form
          child: SingleChildScrollView(
            child: Column(
              children: [
                // campo de texto para o nome
                TextFormField(
                  // permite validação do campo
                  decoration: InputDecoration(labelText: "Digite seu nome", border: OutlineInputBorder()), onChanged: (value) => setState(() {_nome = value;}), 
                  validator: (value)=> value!.isEmpty ? "Campo obrigatório": null,
                ),
                SizedBox(height: 20,),
                // campo email
                TextFormField(
                  decoration: InputDecoration(labelText: "Digite seu email", border: OutlineInputBorder()),
                  onChanged: (value) => setState(() {_email = (value);}),
                  validator: (value) => value!.contains("@") ? null : "Email inválido",
                ),
                SizedBox(height: 20,),
                // campo senha
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Digite sua senha", 
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        _obscureSenha = !_obscureSenha; // inverter o valor para a booleana
                      }), 
                      icon: Icon(_obscureSenha ? Icons.visibility : Icons.visibility_off))),
                  onChanged: (value) => setState(() {_senha = value;}),
                  validator: (value) => value!.length <= 6 ? "A senha deve conter mais do que 6 caracteres" : null,
                  obscureText: _obscureSenha, // esconde a senha // icone para mostrar ou esconder a senha
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Confirme sua senha", 
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        _obscureSenha = !_obscureSenha; // inverter o valor para a booleana
                      }), 
                      icon: Icon(_obscureSenha ? Icons.visibility : Icons.visibility_off))),
                  onChanged: (value) => setState(() {_confirmarSenha = value;}),
                  validator: (value) => value! != _senha ? "As senhas devem ser iguais" : null,
                  obscureText: _obscureSenha,
                ),
                // radio button
                SizedBox(height: 20,),
                // // forma antiga
                // Row(children: [
                //   Text("Sexo:"),
                //   SizedBox(width: 5,),
                //   Radio(
                //     value: "Feminino",
                //     groupValue: _sexo,
                //     onChanged: (value) => setState(()=> _sexo = value!),
                //   ),
                //   Text("Feminino"),
                //   SizedBox(width: 5,),
                //   Radio(
                //     value: "Masculino",
                //     groupValue: _sexo,
                //     onChanged: (value) => setState(()=> _sexo = value!),
                //   ),
                //   Text("Masculino"),
                //   SizedBox(width: 5,),
                //   Radio(
                //     value: "Outros",
                //     groupValue: _sexo,
                //     onChanged: (value) => setState(()=> _sexo = value!),
                //   ),
                //   Text("Outros"),
                // ],),
                // radio versão nova
                // Radio group
                RadioGroup<String>(
                  groupValue: _sexo,
                  onChanged: (String? value)=> setState(() => _sexo = value! ),
                  child: Row(
                    children: [
                      Text("Sexo:"),
                      SizedBox(width: 5,),
                      Radio(value: "Feminino"),
                      Text("Feminino"),
                      SizedBox(width: 5,),
                      Radio(value: "Masculino"),
                      Text("Masculino"),
                      SizedBox(width: 5,),
                      Radio(value: "Outro"),
                      Text("Outro"),
                      SizedBox(width: 5,),
                    ],
                  )
                ),
                // Slider para seleção da idade
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text("Idade: ${_idade.toInt()}"), // exibir a idade
                    Expanded(child: Slider(
                      value: _idade, 
                      onChanged: (value)=> setState(() => _idade = value,),
                      min: 0, // valor minimo do slider
                      max: 100, // valor máximo do slider
                      divisions: 100, // n° de divisões do slider
                      label: _idade.toInt().toString(),
                    )),
                  ],
                ),
                // checkbox para selecionar interesses
                SizedBox(height: 20,),
                Column(children: [
                  Text("Interesses pessoais"),
                  Row(
                    children: [
                      Checkbox(value: _interesses.contains("Cinema"), 
                      onChanged: (bool ? value) => setState(() {
                        value! ? _interesses.add("Cinema") : _interesses.remove("Cinema");
                      })),
                      Text("Cinema 🎬"),
                      SizedBox(width: 5,),
                      Checkbox(value: _interesses.contains("Teatro"), 
                      onChanged: (bool ? value) => setState(() {
                        value! ? _interesses.add("Teatro") : _interesses.remove("Teatro");
                      })),
                      Text("Teatro 🎭"),
                      SizedBox(width: 5,),
                      Checkbox(value: _interesses.contains("Videogame"), 
                      onChanged: (bool ? value) => setState(() {
                        value! ? _interesses.add("Videogame") : _interesses.remove("Videogame");
                      })),
                      Text("Jogos 🎮"),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(value: _interesses.contains("Música"), 
                      onChanged: (bool ? value) => setState(() {
                        value! ? _interesses.add("Música") : _interesses.remove("Música");
                      })),
                      Text("Música 🎵"),
                      SizedBox(width: 5,),
                      Checkbox(value: _interesses.contains("Viagens"), 
                      onChanged: (bool ? value) => setState(() {
                        value! ? _interesses.add("Viagens") : _interesses.remove("Viagens");
                      })),
                      Text("Viagens ✈️"),
                      SizedBox(width: 5,),
                      Checkbox(value: _interesses.contains("Livros"), 
                      onChanged: (bool ? value) => setState(() {
                        value! ? _interesses.add("Livros") : _interesses.remove("Livros");
                      })),
                      Text("Livros 📚"),
                    ],
                  ),
                ],),
                // dropdown cidades
                SizedBox(height: 20,),
                Text("Cidade"),
                DropdownButtonFormField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  // items: [
                  //   DropdownMenuItem(child: Text("Americana"), value: "Americana",),
                  //   DropdownMenuItem(child: Text("Campinas"), value: "Campinas",),
                  //   DropdownMenuItem(child: Text("Nova Odessa"), value: "Nova odessa",),
                  //   DropdownMenuItem(child: Text("Santa Bárbara d'Oeste"), value: "Santa Bárbara d'Oeste",),
                  //   DropdownMenuItem(child: Text("sumaré"), value: "Sumaré",),
                  //   DropdownMenuItem(child: Text("Piracicaba"), value: "Piracicaba",),
                  //   DropdownMenuItem(child: Text("Outra"), value: "Outra",),
                  // ], 
                  items: ["Americana", "Campinas", "Nova Odessa", "Santa Bárbara d'Oeste", "Sumaré", "Piracicaba", "Outra"].map((cidade) => DropdownMenuItem(child: Text(cidade), value: cidade,)
                  ).toList(),
                  onChanged: (value)=> setState(() => _cidade = value!,
                )),
                SizedBox(height: 20,),
                // switch para aceitar os termos de uso
                Row(children: [
                  Switch(value: _aceitarTermos, onChanged: (bool value)=> setState(() => _aceitarTermos = value,)
                  ),
                  Text("Aceitar os termos de uso"),
                ],),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: ()=> _enviarFormulario(), 
                child: Text("Enviar Formulário")),
              ],
            ),
          )
        ),
      ),
      bottomNavigationBar: Bnb(context),
    );
  }

  void _enviarFormulario(){
    //verificar os termos do formulário (validação)
    // mostrar um AlertaDialog (modal de alerta)
    if(formKey.currentState!.validate() && _aceitarTermos){
      showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text("Dados do formulário"),
        content: SingleChildScrollView(
          // permite a rolagem do modal
          child: ListBody(
            children: [
              Text("Nome: ${_nome}"),
              Text("Email: ${_email}"),
              Text("Senha: ${_senha}"),
              Text("Sexo: ${_sexo}"),
              Text("Idade: ${_idade.toInt()}"),
              Text("Interesses: ${_interesses.join(", ")}"),
              Text("Cidade: ${_cidade}")
            ],
          ),
        ),
        actions: [
          ElevatedButton(onPressed: (){
            // sem arrow function para fazer várias ações
            // limpara as respostas
            setState(() {
              _nome ="";
              _email = "";
              _senha = "";
              _confirmarSenha = "";
              _sexo = "Feminino";
              _idade = 18;
              _aceitarTermos = false;
              formKey.currentState!.reset();
            });
            Navigator.popAndPushNamed(context, "/");
          }, 
          child: Text("Ok"))
        ],
      ));
    }
  }
}