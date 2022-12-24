import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paprika/domain/model/models.dart';
import 'package:paprika/presentation/main/pages/recipes/tabs/ingredients/view_model/ingredients_viewmodel.dart';
import 'package:paprika/presentation/resources/assets_manager.dart';
import 'package:paprika/presentation/resources/color_manager.dart';
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
      Ingredient('Cabbage', ImageAssets.cabbage),
      Ingredient('Carrot', ImageAssets.carrot),
      Ingredient('Corn', ImageAssets.corn),
      Ingredient('Eggplant', ImageAssets.eggplant),
      Ingredient('Garlic', ImageAssets.garlic),
      Ingredient('Green Pepper', ImageAssets.greenPepper),
      Ingredient('Red Pepper', ImageAssets.redPepper),
      Ingredient('Yellow Pepper', ImageAssets.yellowPepper),
      Ingredient('Mushrooms', ImageAssets.mushrooms),
      Ingredient('Onion', ImageAssets.onion),
      Ingredient('Potato', ImageAssets.potato),
      Ingredient('Pumpkin', ImageAssets.pumpkin),
      Ingredient('Tomato', ImageAssets.tomato)
    ],
    'Condiments': [
      Ingredient('Salt', ImageAssets.salt),
      Ingredient('Pepper', ImageAssets.pepper),
      Ingredient('Sugar', ImageAssets.sugar),
      Ingredient('Coriander', ImageAssets.coriander),
      Ingredient('Cumin', ImageAssets.cumin),
      Ingredient('Fresh Basil', ImageAssets.freshBasil),
      Ingredient('Oregano', ImageAssets.oregano),
      Ingredient('Paprika', ImageAssets.paprika)
    ],
    'Grocery': [
      Ingredient('Bread', ImageAssets.bread),
      Ingredient('Butter', ImageAssets.butter),
      Ingredient('Cheese', ImageAssets.cheese),
      Ingredient('Egg', ImageAssets.egg),
      Ingredient('Flour', ImageAssets.flour),
      Ingredient('Ketchup', ImageAssets.ketchup),
      Ingredient('Milk', ImageAssets.milk),
      Ingredient('Mustard', ImageAssets.mustard),
      Ingredient('Oil', ImageAssets.oil),
      Ingredient('Pasta', ImageAssets.pasta),
      Ingredient('Rice', ImageAssets.rice)
    ],
    'Meat': [
      Ingredient('Brisket', ImageAssets.beefBrisket),
      Ingredient('Chuck', ImageAssets.beefChuck),
      Ingredient('Rips', ImageAssets.rips),
      Ingredient('Loin', ImageAssets.loin),
      Ingredient('Chicken Breasts', ImageAssets.chickenBreasts),
      Ingredient('Chicken Wings', ImageAssets.chickenWings)
    ],
    'Fish': [
      Ingredient('Mackerel', ImageAssets.mackerel),
      Ingredient('Salmon', ImageAssets.salmon),
      Ingredient('Tuna', ImageAssets.tuna)
    ],
    'Fruits': [
      Ingredient('Apple', ImageAssets.apple),
      Ingredient('Banana', ImageAssets.bananas),
      Ingredient('BlueBerries', ImageAssets.blueBerries),
      Ingredient('Cherries', ImageAssets.cherries),
      Ingredient('Dates', ImageAssets.dates),
      Ingredient('Guava', ImageAssets.guava),
      Ingredient('Mango', ImageAssets.mango),
      Ingredient('Orange', ImageAssets.orange),
      Ingredient('Strawberries', ImageAssets.strawberries),
      Ingredient('WaterMelon', ImageAssets.watermelon)
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
    return TextFormField(
        onTap: () {},
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixIcon: const Icon(Icons.search),
            labelText: 'Search Ingredient',
            labelStyle: Theme.of(context).textTheme.labelSmall,
            enabled: false));
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
                    primary: ColorManager.white,
                    fixedSize: Size(size.width * 0.4, size.height * 0.05),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s8),
                        side:
                            BorderSide(color: ColorManager.darkRed, width: 1))),
                child: Text('Clear List',
                    style: TextStyle(color: ColorManager.darkRed))),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    primary: ColorManager.darkRed,
                    fixedSize: Size(size.width * 0.41, size.height * 0.05),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s8))),
                child: const Text('Search Recipe'))
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
          child:
              Image(image: AssetImage(ingredient.image), fit: BoxFit.contain)),
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
