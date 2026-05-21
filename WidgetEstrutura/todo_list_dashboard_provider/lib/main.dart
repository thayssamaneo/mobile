import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_dashboard_provider/contoller/tarefa_controller.dart';
import 'package:todo_list_dashboard_provider/view/tarefa_view.dart';

void main(List<String> args) {
  runApp(ChangeNotifierProvider(
    create: (context) => TarefaController(),
    child: MaterialApp(
      home: TarefaView(),
    ),
  ));
}