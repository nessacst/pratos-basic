import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'categories_screens.dart';
import 'favorite_screen.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen(this.favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;

  final List<String> _titles = [
    'Lista de Categorias',
    'Meus Favoritos',
  ];

  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens = [
      CategoriesScreen(),
      FavoriteScreen(widget.favoriteMeals),
    ];
  }

  // final List<Widget> _screens = [
  //   CategoriesScreen(),
  //   FavoriteScreen(widget.favoriteMeals),
  // ];

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedScreenIndex]),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.purple,
          systemNavigationBarColor:
              Color.fromRGBO(0xFFE1BEE7, 0xFF8E24AA, 0xFFE1BEE7, 30),
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      drawer: MainDrawer(),
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Color.fromRGBO(0xFFE1BEE7, 0xFF8E24AA, 0xFFE1BEE7, 30),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.purple,
        currentIndex: _selectedScreenIndex, //mostra qual esta selecionado
        // type: BottomNavigationBarType
        //   .shifting, // mostra somente ícone se não estiver selecionado

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: ('Categorias'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
