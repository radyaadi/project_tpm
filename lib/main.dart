import 'package:flutter/material.dart';
import 'package:project_tpm/View/homePage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_tpm/Model/hiveModel.dart';

void main() async{
  Hive.initFlutter();
  Hive.registerAdapter(CocktailHiveAdapter());
  await Hive.openBox<CocktailHive>('cocktail_box');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: Color.fromARGB(255, 31, 111, 63),
      ),
      home: const HomePage()
    );
  }
}


