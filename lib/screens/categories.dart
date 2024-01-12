import 'package:flutter/material.dart';
import 'package:flutter_application_3/data/dummy_data.dart';
import 'package:flutter_application_3/models/category.dart';
import 'package:flutter_application_3/models/meal.dart';
import 'package:flutter_application_3/screens/meals.dart';
import 'package:flutter_application_3/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavorite, required this.availableMeals});

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals.where((meal) => meal.categories.contains(category.id)).toList();
    /*
    flutterda screenler screen stack mantığıyla çalışıyor. 

    scren stack

    categoriesscreen <----- currently visible screen 

    stackin en üstündeki görünür olandır. user topmost layerı görür. 
    Navigator.push() bu stacke yeni bir layer yollar mesela MealsScreen 
    pop() metodu bir tane layerı kaldırır en sondakini yani. mantık bu. 
     */
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          meals: filteredMeals,
          title: category.title,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );

    //alternatif olarak Navigator.of(context).push(route); şeklinde de kullanabiliriz.
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      //gridview güzel bir widget ornegin 2'li 3'lu vs. listeleme seklinde
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2, //alan oranını veriyoruz
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        // availableCategories.map((category)=>CategoryGridItem(category: category)).toList() diyerek de yapabilirdik
        for (final category in availableCategories)
          CategoryGridItem(
              onSelectCategory: () {
                _selectCategory(context, category);
              },
              category: category),
      ],
    );
  }
}
