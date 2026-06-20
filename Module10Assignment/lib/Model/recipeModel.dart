class RecipeModel {
  List<Recipes>? recipes;

  RecipeModel({this.recipes});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    if (json['recipes'] != null) {
      recipes = <Recipes>[];
      json['recipes'].forEach((v) {
        recipes!.add(new Recipes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recipes != null) {
      data['recipes'] = this.recipes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recipes {
  String? title;
  String? description;
  List<String>? ingredients;

  Recipes({this.title, this.description, this.ingredients});

  Recipes.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    ingredients = json['ingredients'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['ingredients'] = this.ingredients;
    return data;
  }
}
