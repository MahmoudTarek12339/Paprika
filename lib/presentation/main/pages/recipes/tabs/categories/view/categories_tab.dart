import 'package:flutter/material.dart';
import 'package:paprika/app/functions.dart';
import 'package:paprika/domain/model/models.dart';
import 'package:paprika/presentation/resources/assets_manager.dart';
import 'package:paprika/presentation/resources/routes_manager.dart';
import 'package:paprika/presentation/resources/strings_manager.dart';
import 'package:paprika/presentation/resources/values_manager.dart';

class CategoriesTap extends StatefulWidget {
  const CategoriesTap({Key? key}) : super(key: key);

  @override
  State<CategoriesTap> createState() => _CategoriesTapState();
}

class _CategoriesTapState extends State<CategoriesTap> {
  final List<Category> categories = [
    Category('Soup', ImageAssets.soup),
    Category('Starters', ImageAssets.starter),
    Category('Lunch', ImageAssets.lunch),
    Category('Dinner', ImageAssets.dinner),
    Category('Salad', ImageAssets.salad),
    Category('Dessert', ImageAssets.dessert),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          heroWidget(
              'search Recipe',
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.searchRecipe);
                  },
                  child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: const Icon(Icons.search),
                          labelText: AppStrings.searchRecipe,
                          labelStyle: Theme.of(context).textTheme.labelSmall,
                          enabled: false)))),
          const SizedBox(height: 15),
          Flexible(
            child: GridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.99,
                crossAxisSpacing: 15,
                shrinkWrap: true,
                children: List.generate(categories.length,
                    (index) => _categoryItem(context, index))),
          )
        ]));
  }

  Widget _categoryItem(context, index) {
    return InkWell(
        onTap: () {},
        child: Column(children: [
          SizedBox(
              height: 125,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.s10),
                  child: heroWidget(
                      categories[index].name,
                      Image(
                          image: AssetImage(categories[index].image),
                          fit: BoxFit.cover)))),
          const SizedBox(height: AppSize.s4),
          Text(categories[index].name,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center)
        ]));
  }
}
