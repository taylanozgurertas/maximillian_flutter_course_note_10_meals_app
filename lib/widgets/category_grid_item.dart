import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category, required this.onSelectCategory});

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //tıklanabilir tappable yapılabilir hale getiriyor InkWell,
      //tabi bu tıklanabilir olması GestureDetector ile de yapılabilir ancak InkWell kullanırsak
      //InkWell kullanırsak güzel bir tıklama efekti de alabiliyoruz InkWell tercih ediyoruz o yüzden genelde
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        //bir container tasarımı oluşturuyoruz
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
