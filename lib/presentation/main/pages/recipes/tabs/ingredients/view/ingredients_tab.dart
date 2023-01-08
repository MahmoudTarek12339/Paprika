
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paprika/app/constants.dart';
import 'package:paprika/domain/model/models.dart';
import 'package:paprika/presentation/main/pages/recipes/tabs/ingredients/view_model/ingredients_viewmodel.dart';
import 'package:paprika/presentation/resources/assets_manager.dart';
import 'package:paprika/presentation/resources/color_manager.dart';
import 'package:paprika/presentation/resources/routes_manager.dart';
import 'package:paprika/presentation/resources/strings_manager.dart';
import 'package:paprika/presentation/resources/values_manager.dart';

class IngredientsTap extends StatefulWidget {
  const IngredientsTap({Key? key}) : super(key: key);

  @override
  State<IngredientsTap> createState() => _IngredientsTapState();
}

class _IngredientsTapState extends State<IngredientsTap> {
  int selectedChip = 0;
  bool containerExpanded = true;
  List<String> chips = [
    'Vegetables',
    'Condiments',
    'Grocery',
    'Meat',
    'Fish',
    'Fruits'
  ];
  final Map<String, List<Ingredient>> ingredients = {
    'Vegetables': [
      Ingredient('Cabbage', ImageAssets.cabbage, false),
      Ingredient('Carrot', ImageAssets.carrot, false),
      Ingredient('Corn', ImageAssets.corn, false),
      Ingredient('Eggplant', ImageAssets.eggplant, false),
      Ingredient('Garlic', ImageAssets.garlic, false),
      Ingredient('Green Pepper', ImageAssets.greenPepper, false),
      Ingredient('Red Pepper', ImageAssets.redPepper, false),
      Ingredient('Yellow Pepper', ImageAssets.yellowPepper, false),
      Ingredient('Mushrooms', ImageAssets.mushrooms, false),
      Ingredient('Onion', ImageAssets.onion, false),
      Ingredient('Potato', ImageAssets.potato, false),
      Ingredient('Pumpkin', ImageAssets.pumpkin, false),
      Ingredient('Tomato', ImageAssets.tomato, false)
    ],
    'Condiments': [
      Ingredient('Salt', ImageAssets.salt, false),
      Ingredient('Pepper', ImageAssets.pepper, false),
      Ingredient('Sugar', ImageAssets.sugar, false),
      Ingredient('Coriander', ImageAssets.coriander, false),
      Ingredient('Cumin', ImageAssets.cumin, false),
      Ingredient('Fresh Basil', ImageAssets.freshBasil, false),
      Ingredient('Oregano', ImageAssets.oregano, false),
      Ingredient('Paprika', ImageAssets.paprika, false)
    ],
    'Grocery': [
      Ingredient('Bread', ImageAssets.bread, false),
      Ingredient('Butter', ImageAssets.butter, false),
      Ingredient('Cheese', ImageAssets.cheese, false),
      Ingredient('Egg', ImageAssets.egg, false),
      Ingredient('Flour', ImageAssets.flour, false),
      Ingredient('Ketchup', ImageAssets.ketchup, false),
      Ingredient('Milk', ImageAssets.milk, false),
      Ingredient('Mustard', ImageAssets.mustard, false),
      Ingredient('Oil', ImageAssets.oil, false),
      Ingredient('Pasta', ImageAssets.pasta, false),
      Ingredient('Rice', ImageAssets.rice, false)
    ],
    'Meat': [
      Ingredient('Brisket', ImageAssets.beefBrisket, false),
      Ingredient('Chuck', ImageAssets.beefChuck, false),
      Ingredient('Rips', ImageAssets.rips, false),
      Ingredient('Loin', ImageAssets.loin, false),
      Ingredient('Chicken Breasts', ImageAssets.chickenBreasts, false),
      Ingredient('Chicken Wings', ImageAssets.chickenWings, false)
    ],
    'Fish': [
      Ingredient('Mackerel', ImageAssets.mackerel, false),
      Ingredient('Salmon', ImageAssets.salmon, false),
      Ingredient('Tuna', ImageAssets.tuna, false)
    ],
    'Fruits': [
      Ingredient('Apple', ImageAssets.apple, false),
      Ingredient('Banana', ImageAssets.bananas, false),
      Ingredient('BlueBerries', ImageAssets.blueBerries, false),
      Ingredient('Cherries', ImageAssets.cherries, false),
      Ingredient('Dates', ImageAssets.dates, false),
      Ingredient('Guava', ImageAssets.guava, false),
      Ingredient('Mango', ImageAssets.mango, false),
      Ingredient('Orange', ImageAssets.orange, false),
      Ingredient('Strawberries', ImageAssets.strawberries, false),
      Ingredient('WaterMelon', ImageAssets.watermelon, false)
    ]
  };

  static final _viewModel = IngredientsViewModel();

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(children: [
            searchWidget(),
            const SizedBox(height: 5),
            SizedBox(
              height: 50,
              child: ListView.builder(
                  itemBuilder: _chipItem,
                  itemCount: chips.length,
                  scrollDirection: Axis.horizontal),
            ),
            const SizedBox(height: 15),
            Flexible(
                child: GridView.count(
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    childAspectRatio: 0.82,
                    crossAxisSpacing: 5,
                    shrinkWrap: true,
                    children: List.generate(
                        ingredients[chips[selectedChip]]?.length ?? 0,
                        (index) => _ingredientItem(context, index))))
          ])),
      _selectedIngredientsWidget()
    ]);
  }

  Widget searchWidget() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.searchIngredient).then((value) {
          List<Ingredient> networkIngredients =
              (value as Map<String, dynamic>)['ingredients'];
          for (int i = 0; i < networkIngredients.length; i++) {
            setState(() {
              _viewModel.updateIngredients(networkIngredients[i]);
            });
          }
        });
      },
      child: TextFormField(
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: const Icon(Icons.search),
              labelText: AppStrings.searchIngredients,
              labelStyle: Theme.of(context).textTheme.labelSmall,
              enabled: false)),
    );
  }

  Widget _chipItem(context, index) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p2),
        child: ChoiceChip(
            label: Text(chips[index],
                style: Theme.of(context).textTheme.bodySmall),
            selected: index == selectedChip,
            selectedColor: ColorManager.primary,
            disabledColor: ColorManager.grey,
            onSelected: (_) => setState(() => selectedChip = index)));
  }

  Widget _ingredientItem(context, index) {
    Ingredient ingredient = ingredients[chips[selectedChip]]![index];
    return Stack(alignment: Alignment.topRight, children: [
      GestureDetector(
          onTap: () {
            _viewModel.updateIngredients(ingredient);
          },
          child: Column(children: [
            Material(
              elevation: AppSize.s8,
              borderRadius: BorderRadius.circular(AppSize.s12),
              color: ColorManager.white,
              child: Container(
                  height: 80,
                  width: 80,
                  margin: const EdgeInsets.all(AppMargin.m8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    color: ColorManager.white,
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image(
                      image: AssetImage(ingredient.image),
                      fit: BoxFit.contain)),
            ),
            const SizedBox(height: 5),
            Text(ingredient.name, style: Theme.of(context).textTheme.bodyMedium)
          ])),
      StreamBuilder<List<Ingredient>>(
          stream: _viewModel.outputIngredients,
          builder: (context, snapShot) {
            if (snapShot.hasData && snapShot.data!.isNotEmpty) {
              bool selected = snapShot.data!
                  .where((e) => e.name == ingredient.name)
                  .isNotEmpty;
              if (selected) {
                return Icon(Icons.beenhere,
                    size: AppSize.s20, color: ColorManager.darkRed);
              } else {
                return const SizedBox.shrink();
              }
            } else {
              return const SizedBox.shrink();
            }
          })
    ]);
  }

  Widget _selectedIngredientsWidget() {
    return StreamBuilder<List<Ingredient>>(
        stream: _viewModel.outputIngredients,
        builder: (context, snapShot) {
          if (snapShot.hasData && snapShot.data!.isNotEmpty) {
            return selectedWidget(snapShot.data ?? []);
          } else {
            return const SizedBox();
          }
        });
  }

  Widget selectedWidget(List<Ingredient> ingredients) {
    return DraggableScrollableSheet(
        initialChildSize: 0.35,
        minChildSize: 0.2,
        maxChildSize: 0.5,
        builder: (context, controller) {
          return selectedIngredientContainer(ingredients, controller);
        });
  }

  Widget selectedIngredientContainer(
      List<Ingredient> ingredients, ScrollController controller) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(bottom: AppMargin.m12),
        padding: const EdgeInsets.all(AppPadding.p14),
        decoration: BoxDecoration(
            color: ColorManager.grey.withOpacity(0.8),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(AppSize.s28))),
        child: Column(children: [
          Expanded(
              child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  controller: controller,
                  crossAxisCount: 5,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 5,
                  shrinkWrap: true,
                  children: List.generate(ingredients.length,
                      (index) => _selectedIngredientItem(ingredients[index])))),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
                onPressed: () {
                  _viewModel.clearIngredients();
                },
                style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    backgroundColor: ColorManager.white,
                    fixedSize: Size(size.width * 0.4, size.height * 0.05),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s8),
                        side:
                            BorderSide(color: ColorManager.darkRed, width: 1))),
                child: Text(AppStrings.clearList,
                    style: TextStyle(color: ColorManager.darkRed))),
            ElevatedButton(
                onPressed: () {
                  String ingredients = '';
                  _viewModel.getIngredients().forEach((ingredient) {
                    ingredients += '${ingredient.name},';
                  });
                  ingredients =
                      ingredients.substring(0, ingredients.length - 1);
                  Navigator.pushNamed(context, Routes.ingredientRecipesResults,
                      arguments: {'ingredients': ingredients});
                },
                style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    backgroundColor: ColorManager.darkRed,
                    fixedSize: Size(size.width * 0.41, size.height * 0.05),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s8))),
                child: const Text(AppStrings.searchRecipe))
          ])
        ]));
  }

  Widget _selectedIngredientItem(Ingredient ingredient) {
    return Stack(children: [
      Container(
          height: 50,
          width: 50,
          margin: const EdgeInsets.all(AppMargin.m8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s12),
            color: ColorManager.white,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
              padding: const EdgeInsets.all(AppPadding.p5),
              child: !ingredient.isNetwork
                  ? Image(
                      image: AssetImage(ingredient.image), fit: BoxFit.contain)
                  : Image(
                      fit: BoxFit.contain,
                      image: NetworkImage(
                          Constants.ingredientImageUrl + ingredient.image),
                      loadingBuilder: (context, widget, progress) {
                        if (progress == null) return widget;
                        return Center(
                            child: CircularProgressIndicator(
                                color: ColorManager.black));
                      },
                      errorBuilder: (context, object, _) {
                        return const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(ImageAssets.paprika));
                      }))),
      Positioned(
          top: -10,
          right: -10,
          child: IconButton(
              onPressed: () {
                _viewModel.updateIngredients(ingredient);
              },
              icon: FaIcon(FontAwesomeIcons.circleMinus,
                  color: ColorManager.red, size: AppSize.s18)))
    ]);
  }
}
