import 'package:flutter/material.dart';
import 'package:meals/screens/favorite_screen.dart';
import 'utils/app_routes.dart';
import 'screens/settings_screen.dart';

import 'screens/categories_meals_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/meal_detail_screen.dart';

import 'data/dummy_data.dart';
import 'models/meal.dart';
import 'models/filters.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();

  List<Meal> _availableMeals =
      DUMMY_MEALS; // recebe todas as comidas por padrão
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;

      _availableMeals = DUMMY_MEALS.where((meal) {
        // se algum dos filtros for verdadeiro, a comida não é exibida
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegetarian &&
            !filterVegan; // se não caiu em nenhum filtro a comida é exibida
      }).toList();
    });
  }

  void _toggleeFavorite(Meal meal) {
    setState(() {
      // se tiver contido remora, se não tiver adiciona
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Vamos Cozinhar?',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.light(),
        fontFamily: 'Raleway',
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      //home: CategoriesScreen(),
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreen(_favoriteMeals), // home
        AppRoutes.CATEGORIES_MEALS: (ctx) =>
            CategoriesMealsScreen(_availableMeals),
        AppRoutes.MEAL_DETAIL: (ctx) =>
            MealDetailScreen(_toggleeFavorite, _isFavorite),
        //AppRoutes.SETTINGS: (ctx) => SettingsScreen(settings, _filterMeals),
      },
    );
  }
}
