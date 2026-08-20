// classe controller --> dica:  SlimController

import 'package:biblioteca_api_json/model/book_model.dart';
import 'package:biblioteca_api_json/service/api_service.dart';

class BookController {
  // não precisa criar um obj da classe apiService porque ela é estatíca, não precisa instanciar objs
  
  // métodos

  // fetch | read
  Future<List<BookModel>> fetchAll() async{
    final list = await ApiService.getList("books"); // estabelece a conexão
    return list.map((item)=>BookModel.fromMap(item)).toList(); // transforma o resultado em uma lista de objetos
  }

  // fetchOne | readOne
  Future<BookModel> fetchOne(String id) async{
    final Map<String, dynamic> book = await ApiService.getOne("books", id);
    return BookModel.fromMap(book);
  }

  // create
  Future<BookModel> create(BookModel book) async{
    final map = await ApiService.post("books", book.toMap());
    return BookModel.fromMap(map);
  }

  // update
  Future<BookModel> update(BookModel book) async{
    final map = await ApiService.put("books", book.toMap(), book.id!); // ! ou ?? --> !: força o valor a ser nulo | ??: tem valor reserva caso nulo
    return BookModel.fromMap(map);
  }

  // delete
  void delete(String id) async{
    await ApiService.delete("books", id);
  }
}