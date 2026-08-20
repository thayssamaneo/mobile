import 'package:biblioteca_api_json/controller/book_controller.dart';
import 'package:biblioteca_api_json/model/book_model.dart';
import 'package:flutter/material.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  // atributos
  List<BookModel> _books = [];
  List<BookModel> _filterBook = [];
  final bookSearch = TextEditingController();
  String _erro = "";
  bool _isLoading = true;

  final _bookController = BookController();

  // métodos

  // carregar as informações antes do build
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async{
    setState(() {
      _isLoading = true;
    });
    // conexão com a API
    try {
      _books = await _bookController.fetchAll();
      _filterBook = _books;

    } catch (e) {
      _erro = e.toString();
    }
    setState(() {
      _isLoading = false;
    });
  }

  // filtrar os usuários CRS

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}