class BookModel {
  // atributos
  String? id;
  String title;
  String author;
  bool avaliable;

  // construtor
  BookModel({this.id, required this.title, required this.author, required this.avaliable});

  // métodos (ToMap e FromMap usando factory )
  // toMap
  Map<String, dynamic> toMap()=>{
    "id": id,
    "title": title,
    "author": author,
    "avaliable": avaliable,
  };

  // fromMap
  factory BookModel.fromMap(Map<String, dynamic> map)=>BookModel(
    id: map["id"],
    title: map["title"].toString(), 
    author: map["author"].toString(), 
    avaliable: map["avaliable"] == true ? true : false // verificação da booleana
  );
}