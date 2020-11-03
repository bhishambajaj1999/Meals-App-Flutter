import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';

import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Map<String,bool> _filters={
    'glutten':false,
    'lactose':false,
    'vegan':false,
    'vegetarian':false,
  };
  List<Meal> availableMeals=DUMMY_MEALS;
  List<Meal> favouriteMeals=[];
  void _setFilters(Map<String,bool> filterData){
setState(() {
  _filters=filterData;
  availableMeals=DUMMY_MEALS.where((meal) {
if(_filters['glutten'] && !meal.isGlutenFree){
  return false;
}
if(_filters['vegan'] && !meal.isVegan){
  return false;
}
if(_filters['lactose'] && !meal.isLactoseFree){
  return false;
}
if(_filters['vegetarian'] && !meal.isVegetarian){
  return false;
}
return true;
  }).toList();
});
  }
  void _toggleFavourite(String mealId){
    final existing=favouriteMeals.indexWhere((meal) => meal.id==mealId);
    if(existing>=0){
      setState(() {
        favouriteMeals.removeAt(existing);
      });
    }
    else{
      setState(() {
        favouriteMeals.add(DUMMY_MEALS.firstWhere((element) => element.id==mealId));
      });
    }
  }
  bool _isMealFavourite(String id){
   return favouriteMeals.any((element) => element.id==id);
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => TabsScreen(favouriteMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavourite,_isMealFavourite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters,_setFilters),
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      },
    );
  }
}
