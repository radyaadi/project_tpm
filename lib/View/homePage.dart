import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_tpm/Model/cockTailModel.dart';
import 'package:project_tpm/Controller/apiRequest.dart';
import 'package:project_tpm/View/cockTailList.dart';
import 'package:project_tpm/View/cockTailFavourite.dart';
import 'package:project_tpm/Model/hiveModel.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key,}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CockTail List",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 24.0
              )
            ),
        automaticallyImplyLeading: false,
      ),
      body: _buildDetailCocktailBody(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: 'View My Cart',
            child: Icon( Icons.add_shopping_cart_outlined,
            color: Color.fromARGB(255, 255, 255, 255),),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CockTailFavourite();
                }));
              },
          ),
        ]
      )
    );
  }

  Widget _buildDetailCocktailBody() {
    return Container(
      child: FutureBuilder(
        future:  CocktailDataSource.instance.loadCocktail(),
        builder: (BuildContext context,
            AsyncSnapshot<dynamic> snapshot,) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            CockTailModel cocktailModel = CockTailModel.fromJson(snapshot.data);
            return _buildSuccessSection(cocktailModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildEmptySection() {
    return Text("Empty");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

   Widget _buildSuccessSection(CockTailModel data) {
    return ListView.builder(
      itemCount: data.drinks?.length,
      itemBuilder: (BuildContext context, int index) {
        return CockTailList(
          name: "${data.drinks?[index].strDrink}",
          category: "${data.drinks?[index].strCategory}",
          image: "${data.drinks?[index].strDrinkThumb}",
          ingredient1: "${data.drinks?[index].strIngredient1}",
          ingredient2: "${data.drinks?[index].strIngredient2}"
        );
      },
    );
  }
}