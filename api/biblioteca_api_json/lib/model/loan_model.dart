class LoanModel {
  // atributos
  String? id;
  String userId;
  String bookId;
  DateTime startDate;
  DateTime dueDate;
  bool returned;

  // construtor
  LoanModel({this.id, required this.userId, required this.bookId, required this.startDate, required this.dueDate, required this.returned});

  //ToMap --> mapear pra pegar os valores
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'bookId': bookId,
      'startDate': startDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'returned': returned,
    };
  }

  // fromMap
  factory LoanModel.fromMap(Map map) => LoanModel(
      id: map['id'].toString(),
      userId: map["userId"], // UserModel.fromMap(map["user"])
      bookId: map["bookId"], // BookModel.fromMap(map["book"])
      startDate: DateTime.parse(map['startDate'].toString()),
      dueDate: DateTime.parse(map['dueDate'].toString()),
      returned: map['returned'] == true ? true : false,
  );
}