import 'package:flutter/material.dart';
import 'package:meal_application/models/meal.dart';
import 'package:meal_application/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favMeals;

  const FavoritesScreen (this.favMeals);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favMeals[index].id,
            title: favMeals[index].title,
            imageUrl: favMeals[index].imageUrl,
            duration: favMeals[index].duration,
            complexity: favMeals[index].complexity,
            affordability: favMeals[index].affordability,
          );
        },
        itemCount: favMeals.length,
      ),
    );
  }
}
