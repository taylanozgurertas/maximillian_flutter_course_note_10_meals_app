import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/meal.dart';
import 'package:flutter_application_3/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';
/*
transparent image package kullanıyoruz bu package 
transparent image veriyor bize kullanımı basit 
ImageProvider isteniyorsa MemoryImage(kTransparentImage) 
ama yok eğer Image isteniyorsa
Image.memory(kTransparentImage) şeklinde kullanabiliriz.
 */

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
    //bir textin ilk harfini bu şekilde büyük harf yapabiliriz.
    //substring keser bir kısmını 1.indexten başlat demiş oluyoruz
    //textleri böyle + ile toplanabilir bu şekilde 'Hello' + 'World' = HelloWorld
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge, //alt widgetların shape sınırlarına çıkmasını engeller
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          /*
          Stack widgetı widgetları üst üste pozisyonlamaya yarar direkt üst üste yani 
          image üzerine yazı yazmak tarzında
           */
          children: [
            //FadeInImage efekt yapmaya yarar placeholder ve image ister
            FadeInImage(
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
            ),

            Positioned(
              //widgetı pozisyonlamaya yarar stack içerisinde epey kullanılır
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                  child: Column(
                    children: [
                      Text(meal.title,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis, //very long text ...
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemTrait(
                            icon: Icons.schedule,
                            label: '${meal.duration} min',
                          ),
                          const SizedBox(width: 12),
                          MealItemTrait(
                            icon: Icons.work,
                            label: complexityText,
                          ),
                          const SizedBox(width: 12),
                          MealItemTrait(
                            icon: Icons.attach_money,
                            label: affordabilityText,
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
