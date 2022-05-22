import 'package:flutter/material.dart';
import 'package:project_tpm/View/cockTailList.dart';
import 'package:project_tpm/View/HomePage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_tpm/Model/hiveModel.dart';

class CockTailFavourite extends StatefulWidget {
  const CockTailFavourite({Key? key}) : super(key: key);

  @override
  _CockTailFavouriteState createState() => _CockTailFavouriteState();
}

class _CockTailFavouriteState extends State<CockTailFavourite> {

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favourite List"),
        automaticallyImplyLeading: false,
      ),
      body: ValueListenableBuilder(
          valueListenable:
          Hive.box<CocktailHive>('cocktail_box').listenable(),
          builder: (context, Box<CocktailHive> box, _) {
            if (box.values.isEmpty) {
              return Center(
                child: Text('You have no items'),
              );
            }
            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                CocktailHive? res = box.getAt(index);
                return Dismissible(
                  background: Container(
                    color: Colors.red,
                  ),
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    res!.delete();
                    showSnackbar();
                  },
                  child: Card(
                    child: Row(
                      children:<Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child:CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(res!.image),
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
                              Text(res.name,
                                style: TextStyle(
                                  fontSize: 24.0
                                )
                              ),
                              SizedBox(height: 8.0),
                              Text("Ingredients :  ${res.ingredient1} and ${res.ingredient2}",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 167, 171, 176),
                                  fontSize: 12.0
                                )
                              ),
                              Text("Category     :  ${res.category}",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 167, 171, 176),
                                  fontSize: 12.0
                                )
                              ),
                              SizedBox(height: 10.0),
                            
                              SizedBox(height: 8.0),
                            ]
                          )
                        )
                      ]
                    )
                  )
                );
              },
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Home Page',
        child: Icon( Icons.arrow_back),
        onPressed: ()=>{
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePage()))
        },
      ),
    );
  }

  void showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item removed'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}