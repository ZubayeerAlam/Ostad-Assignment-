import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:module10assignment/Ui/recipeApp.dart';

void main(){
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RecipeApp( ),
    );
  }
}
