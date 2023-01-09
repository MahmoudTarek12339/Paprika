import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:paprika/app/di.dart';
import 'package:paprika/app/functions.dart';
import 'package:paprika/domain/model/models.dart';
import 'package:paprika/presentation/categoryRecipes/view_model/category_recipes_viewmodel.dart';
import 'package:paprika/presentation/resources/assets_manager.dart';
import 'package:paprika/presentation/resources/color_manager.dart';
import 'package:paprika/presentation/resources/font_manager.dart';
import 'package:paprika/presentation/resources/routes_manager.dart';
import 'package:paprika/presentation/resources/strings_manager.dart';
import 'package:paprika/presentation/resources/styles_manager.dart';
import 'package:paprika/presentation/resources/values_manager.dart';

class CategoryRecipesView extends StatefulWidget {
  final Category category;

  const CategoryRecipesView(this.category, {Key? key}) : super(key: key);

  @override
  State<CategoryRecipesView> createState() => _CategoryRecipesViewState();
}

class _CategoryRecipesViewState extends State<CategoryRecipesView> {
  final CategoryRecipesViewModel _viewModel =
      instance<CategoryRecipesViewModel>();

  _bind() {
    _viewModel.start();
    _viewModel.getRecipesData(widget.category.name);
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox.expand(
                child: Column(children: [
      Stack(alignment: Alignment.topLeft, children: [
        _imageWidget(context),
        Padding(
            padding: const EdgeInsets.only(top: AppPadding.p5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new,
                          color: ColorManager.white, size: 26)),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.searchRecipe);
                      },
                      icon: Icon(Icons.search_sharp,
                          color: ColorManager.white, size: 26))
                ]))
      ]),
      Expanded(
        child: StreamBuilder<List<RecipeData>>(
            stream: _viewModel.outputRecipesData,
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                if (snapShot.data!.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              ' ${snapShot.data!.length} ${AppStrings.recipes}',
                              style: Theme.of(context).textTheme.labelMedium),
                          const SizedBox(height: AppSize.s4),
                          Expanded(
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: snapShot.data!.length,
                                  itemBuilder: (context, index) => _recipeItem(
                                      context, snapShot.data![index], index)))
                        ]),
                  );
                } else {
                  return Center(
                      child: Text(AppStrings.noResultFound,
                          style: Theme.of(context).textTheme.titleLarge));
                }
              } else {
                return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      SizedBox(
                          height: AppSize.s100,
                          width: AppSize.s100,
                          child: Lottie.asset(JsonAssets.loading,
                              height: AppSize.s60, width: AppSize.s60)),
                      Center(
                          child: Padding(
                              padding: const EdgeInsets.all(AppPadding.p8),
                              child: Text(AppStrings.loading,
                                  style: getSemiBoldStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.s24))))
                    ]));
              }
            }),
      )
    ]))));
  }

  Widget _imageWidget(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Stack(alignment: Alignment.center, children: [
      Image(
          fit: BoxFit.cover,
          height: height * 0.3,
          width: double.infinity,
          image: AssetImage(widget.category.image)),
      Container(
          height: height * 0.3,
          width: double.infinity,
          color: ColorManager.white.withOpacity(0.3)),
      Column(children: [
        heroWidget(
          widget.category.name,
          CircleAvatar(
              backgroundColor: ColorManager.white,
              minRadius: 30,
              maxRadius: 50,
              child: CircleAvatar(
                  backgroundImage: AssetImage(widget.category.image),
                  minRadius: 27,
                  maxRadius: 47)),
        ),
        const SizedBox(height: AppSize.s4),
        Text(widget.category.name,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: ColorManager.white))
      ])
    ]);
  }

  Widget _recipeItem(context, RecipeData recipe, int index) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: GestureDetector(
            onTap: () {
              //navigate to next page with fade animation
              Navigator.pushNamed(context, Routes.recipeDetails, arguments: {
                'recipe': recipe,
                'tag': '${widget.category.name} +$index'
              });
            },
            child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(AppSize.s12),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: ColorManager.white,
                child: Container(
                    height: height * 0.15,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        color: ColorManager.white),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 2,
                              child: SizedBox(
                                  height: height * 0.15,
                                  child: heroWidget(
                                      '${widget.category.name} +$index',
                                      Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              recipe.recipeInformation!.image),
                                          loadingBuilder:
                                              (context, widget, progress) {
                                            if (progress == null) return widget;
                                            return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: ColorManager
                                                            .black));
                                          },
                                          errorBuilder: (context, object, _) {
                                            return const Image(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    ImageAssets.lunch));
                                          })))),
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p5,
                                    vertical: AppPadding.p2),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(recipe.recipeInformation!.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge),
                                      const SizedBox(height: AppSize.s12),
                                      Row(children: [
                                        RatingBarIndicator(
                                            itemCount: 5,
                                            rating: ((recipe.recipeInformation!
                                                            .aggregateLikes /
                                                        5) %
                                                    5)
                                                .ceilToDouble(),
                                            itemSize: AppSize.s16,
                                            itemBuilder: (context, index) =>
                                                const Icon(Icons.star,
                                                    color: Colors.amberAccent)),
                                        const SizedBox(width: AppSize.s4),
                                        Text(
                                            '${recipe.recipeInformation!.aggregateLikes} ${AppStrings.reviews}')
                                      ]),
                                      const SizedBox(height: AppSize.s5),
                                      Row(children: [
                                        Icon(Icons.timer_outlined,
                                            color: ColorManager.darkRed,
                                            size: 18.0),
                                        const SizedBox(width: AppSize.s4),
                                        Text(
                                            '${recipe.recipeInformation!.readyInMinutes} ${AppStrings.minute}')
                                      ])
                                    ]),
                              ))
                        ])))));
  }
}
