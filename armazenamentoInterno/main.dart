void main(List<String> args){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: "PetShopp SqLite",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch:Colors.deepOrange),
    home: HomeScreen(),
  ));
}