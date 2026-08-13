import 'package:flutter/material.dart';
import 'package:json_pathprovider_cadastrarprodutos/json_helper.dart';

class CadastarPage extends StatefulWidget {

  const CadastarPage({super.key});

  @override
  State<CadastarPage> createState() => _CadastarPageState();
}

class _CadastarPageState extends State<CadastarPage> {

  // atributos
  Map<String, dynamic> _db = {};
  final TextEditingController _nomeProduto = TextEditingController();
  List<Map<String,dynamic>> _produtos = [];

  // métodos CRUD
  // criar um método para carregar os produtos
  void _carregarProdutos() async {
    final dados = await JsonHelper.lerDados();
    setState(() {
      _db = dados;
    });
  }

  // método para adicionar um produto
  void _cadastrarTarefa() async{
    setState(() {
      _produtos.add(
        {
          "nome": "Novo Produto ${_produtos.length+1}",
          "emEstoque": false,
          "preco": "Não informado",
        }
      );
      _salvarAlteracoesJSON();
    });
  }

  // método para atualizar as informações no JSON
  void _atualizarProduto(int index) async{
    setState(() {
      _produtos[index]["emEstoque"] = !_produtos[index]["emEstoque"];
    });
    _salvarAlteracoesJSON();
  }

  // método para atuar no JSON
  void _salvarAlteracoesJSON(){
    _db = _produtos;
    JsonHelper.salvarDados(_db);
  }

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}