import 'package:flutter/material.dart';
import 'package:meal_application/dummy_data.dart';
import 'package:meal_application/screens/category_meals_screen.dart';
import 'package:meal_application/screens/category_screen.dart';
import 'package:meal_application/screens/filter_screen.dart';
import 'package:meal_application/screens/meal_detail_screen.dart';
import 'package:meal_application/screens/tab_screen.dart';

import 'models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favMeals = [];

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = _availableMeals.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) return false;
        if (_filters['lactose'] && !meal.isLactoseFree) return false;
        if (_filters['vegan'] && !meal.isVegan) return false;
        if (_filters['vegetarian'] && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFav(String mealId) {
    if (_isFav(mealId))
      _favMeals.removeWhere((meal) => meal.id == mealId);
    else
      _favMeals.add(_availableMeals.firstWhere((meal) => meal.id == mealId));
  }

  bool _isFav(String mealId){return _favMeals.any((meal) => meal.id == mealId);}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Meal App'),
      routes: {
        '/': (context) => TabsScreen(_favMeals),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_isFav, _toggleFav),
        FilterScreen.routeName: (context) => FilterScreen(_filters, setFilters),
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: CategoriesScreen(),
//     );
//   }
// }
