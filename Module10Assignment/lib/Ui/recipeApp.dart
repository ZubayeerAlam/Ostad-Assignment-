import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:module10assignment/controller/recipeController.dart';


class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key});


  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  RecipeController recipeController = RecipeController();

  @override
  void initState() {
    super.initState();
    recipeController.fetchRecipes();
  }

  Future fetchData() async{
    await recipeController.fetchRecipes();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Food Recipes ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.lightBlue,
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: recipeController.recipes!.length,
              itemBuilder: (context, index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(12),

                    child: Row(
                      children: [
                        //logo
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.fastfood,
                            size: 28,
                            color: Colors.grey.shade700,
                          ),
                        ),

                        SizedBox(width: 10),
                        //Dish & ingredient
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recipeController.recipes![index].title.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  recipeController.recipes![index].description.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
