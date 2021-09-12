import 'package:flutter/material.dart';
import 'package:meal_application/dummy_data.dart';
import 'package:meal_application/models/meal.dart';
import 'package:meal_application/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  final List<Meal> availableMeals;
  static const routeName = 'category_meals';

  const CategoryMealsScreen(this.availableMeals);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String title;
  List<Meal> displayMeals;

  void _removeItem(String mealId) {
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String id = routeArgs['id'];
    title = routeArgs['title'];
    displayMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(id);
    }).toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayMeals[index].id,
            title: displayMeals[index].title,
            imageUrl: displayMeals[index].imageUrl,
            duration: displayMeals[index].duration,
            complexity: displayMeals[index].complexity,
            affordability: displayMeals[index].affordability,
          );
        },
        itemCount: displayMeals.length,
      ),
    );
  }
}
