import 'package:flutter/material.dart';
import 'package:paprika/presentation/main/pages/recipes/tabs/categories/view/categories_tab.dart';
import 'package:paprika/presentation/main/pages/recipes/tabs/ingredients/view/ingredients_tab.dart';
import 'package:paprika/presentation/resources/color_manager.dart';
import 'package:paprika/presentation/resources/strings_manager.dart';
import 'package:paprika/presentation/resources/values_manager.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({Key? key}) : super(key: key);

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: ColorManager.white,
            centerTitle: false,
            titleSpacing: AppSize.s20,
            elevation: 0,
            title: Text(AppStrings.paprika,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: ColorManager.darkRed)),
            bottom: TabBar(
                controller: _tabController,
                tabs: const [Tab(text: 'CATEGORIES'), Tab(text: 'INGREDIENTS')],
                unselectedLabelColor: ColorManager.grey,
                indicatorColor: ColorManager.darkRed,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 70),
                labelColor: ColorManager.darkRed,
                labelStyle: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: ColorManager.darkRed),
                indicatorWeight: 3.0)),
        body: TabBarView(
            controller: _tabController,
            children: [CategoriesTap(), IngredientsTap()]));
  }
}
