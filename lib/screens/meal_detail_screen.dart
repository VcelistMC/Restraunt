import 'package:flutter/material.dart';
import 'package:meal_application/dummy_data.dart';

class MealDetailScreen extends StatefulWidget {
  static const String routeName = "meal_detail";
  final Function isFav;
  final Function toggleFav;

  const MealDetailScreen(this.isFav, this.toggleFav);

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Widget buildSectionTitle(String title) {
    return Container(
      child: Text(title),
      margin: EdgeInsets.symmetric(vertical: 10),
    );
  }

  Widget buildSection(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 250,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    bool isFavourite = widget.isFav(mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle("Ingredients"),
            buildSection(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  child: Padding(
                    child: Text(selectedMeal.ingredients[index]),
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle("Steps"),
            buildSection(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text("${index + 1}"),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.toggleFav(mealId);
          setState(() {
            isFavourite = !isFavourite;
          });
        },
        child: widget.isFav(mealId)
            ? Icon(Icons.favorite)
            : Icon(Icons.favorite_border),
      ),
    );
  }
}
