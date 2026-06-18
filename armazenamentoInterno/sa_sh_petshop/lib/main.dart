import 'package:flutter/material.dart';
import 'package:sa_sh_petshop/screen/home_screen.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: "PetShop SqLite",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.lightBlue),
    home: HomeScreen(),
  ));
}