import 'package:flutter/material.dart';
import 'package:project_tpm/View/cockTailList.dart';
import 'package:project_tpm/View/cockTailFavourite.dart';
import 'package:project_tpm/Model/hiveModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class CockTailList extends StatefulWidget {
  String name;
  String category;
  String image;
  String ingredient1;
  String ingredient2;
  
  CockTailList({ Key? key,
    required this.name,
    required this.category,
    required this.image,
    required this.ingredient1,
    required this.ingredient2,
  }) : super(key: key);

  @override
  State<CockTailList> createState() => _CockTailListState();
}

class _CockTailListState extends State<CockTailList> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children:<Widget>[
          Container(
            width: 100,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child:CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(widget.image),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(widget.name,
                  style: TextStyle(
                    fontSize: 24.0
                  )
                ),
                SizedBox(height: 8.0),
                Text("Ingredients :  ${widget.ingredient1} and ${widget.ingredient2}",
                  style: TextStyle(
                    color: Color.fromARGB(255, 167, 171, 176),
                    fontSize: 12.0
                  )
                ),
                Text("Category     :  ${widget.category}",
                  style: TextStyle(
                    color: Color.fromARGB(255, 167, 171, 176),
                    fontSize: 12.0
                  )
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  padding: EdgeInsets.all(15),
                  textColor: Colors.white,
                  color: Color.fromARGB(255, 31, 111, 63),
                  onPressed: () {
                    Box<CocktailHive> cocktailBox = Hive.box<CocktailHive>('cocktail_box');
                    cocktailBox.add(
                      CocktailHive(
                        name: widget.name,
                        category: widget.category,
                        image: widget.image,
                        ingredient1: widget.ingredient1,
                        ingredient2: widget.ingredient2,
                      )
                    );
                    print(cocktailBox);
                    showSnackbar();
                  },
                  child: Text("Add to Favorites",
                    style: TextStyle(fontSize: 12.0)
                  ),
                ),
                SizedBox(height: 8.0),
              ]
            )
          )
        ]
      )
    );
  }

  void showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item added'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}