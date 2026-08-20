import 'package:biblioteca_api_json/model/loan_model.dart';
import 'package:biblioteca_api_json/service/api_service.dart';

class LoanController {
  // métodos
  // Métodos dos empréstimos: +getLoans() +postLoans() +putLoan(String id)

  // fetch
  Future<List<LoanModel>> fetchAll() async{
    final list = await ApiService.getList("loans");
    return list.map((item)=>LoanModel.fromMap(item)).toList();
  }

  // fecthOne
  Future<LoanModel> fetchOne(String id) async{
    final Map<String,dynamic> Loan = await ApiService.getOne("Loans", id);
    return LoanModel.fromMap(Loan);
  }

  //create
  Future<LoanModel> create(LoanModel loan) async{
    final map = await ApiService.post("Loans", loan.toMap());
    return LoanModel.fromMap(map);
  }

  //update
  Future<LoanModel> update(LoanModel loan) async{
    final map = await ApiService.put("loans", loan.toMap(), loan.id!);
    return LoanModel.fromMap(map);
  }
}