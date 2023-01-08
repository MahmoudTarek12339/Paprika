
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:paprika/app/di.dart';
import 'package:paprika/app/functions.dart';
import 'package:paprika/domain/model/models.dart';
import 'package:paprika/presentation/recipesResults/view_model/recipes_results_viewmodel.dart';
import 'package:paprika/presentation/resources/assets_manager.dart';
import 'package:paprika/presentation/resources/color_manager.dart';
import 'package:paprika/presentation/resources/font_manager.dart';
import 'package:paprika/presentation/resources/routes_manager.dart';
import 'package:paprika/presentation/resources/strings_manager.dart';
import 'package:paprika/presentation/resources/values_manager.dart';

import '../../resources/styles_manager.dart';

class RecipesResultsView extends StatefulWidget {
  final String query;

  const RecipesResultsView(this.query, {Key? key}) : super(key: key);

  @override
  State<RecipesResultsView> createState() => _RecipesResultsViewState();
}

class _RecipesResultsViewState extends State<RecipesResultsView> {
  final RecipesResultViewModel _viewModel = instance<RecipesResultViewModel>();

  _bind() {
    _viewModel.start();
    _viewModel.searchRecipes(widget.query);
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
    return Scaffold(
        appBar: AppBar(
            backgroundColor: ColorManager.white,
            centerTitle: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:
                    Icon(Icons.arrow_back_ios_new, color: ColorManager.black)),
            title: Text(AppStrings.searchResults,
                style: Theme.of(context).textTheme.labelLarge)),
        body: SizedBox.expand(
            child: Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: StreamBuilder<List<SearchRecipeResults>>(
                    stream: _viewModel.outputRecipesResult,
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        if (snapShot.data!.isNotEmpty) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' ${snapShot.data!.length} ${AppStrings.recipes}',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                const SizedBox(height: AppSize.s4),
                                Expanded(
                                    child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: snapShot.data!.length,
                                        itemBuilder: (context, index) =>
                                            _resultItem(context,
                                                snapShot.data![index])))
                              ]);
                        } else {
                          return Center(
                              child: Text(AppStrings.noResultFound,
                                  style:
                                      Theme.of(context).textTheme.titleLarge));
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
                                      padding:
                                          const EdgeInsets.all(AppPadding.p8),
                                      child: Text(AppStrings.loading,
                                          style: getSemiBoldStyle(
                                              color: ColorManager.black,
                                              fontSize: FontSize.s24))))
                            ]));
                      }
                    }))));
  }

  Widget _resultItem(context, SearchRecipeResults result) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: GestureDetector(
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s14)),
                        elevation: AppSize.s1_5,
                        backgroundColor: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                                color: ColorManager.white,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.circular(AppSize.s14),
                                boxShadow: const [
                                  BoxShadow(color: Colors.black26)
                                ]),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: AppSize.s100,
                                      width: AppSize.s100,
                                      child: Lottie.asset(JsonAssets.loading,
                                          height: AppSize.s60,
                                          width: AppSize.s60)),
                                  Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(
                                              AppPadding.p8),
                                          child: Text(AppStrings.loading,
                                              style: getSemiBoldStyle(
                                                  color: ColorManager.black,
                                                  fontSize: FontSize.s24))))
                                ])));
                  });
              await _viewModel.getRecipe(result.id).then((value) {
                Navigator.pop(context);
                if (value != null) {
                  //navigate to next page with fade animation
                  Navigator.pushNamed(context, Routes.recipeDetails,
                      arguments: {
                        'recipe': value,
                        'tag': 'soup +${result.id}'
                      });
                }
              });
            },
            child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(AppSize.s12),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: ColorManager.white,
                child: Container(
                    height: height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        color: ColorManager.white),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: height * 0.17,
                              width: double.infinity,
                              child: _imageWidget(
                                  result.image, 'soup +${result.id}')),
                          const SizedBox(height: AppSize.s12),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p14),
                              child: Text(result.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium))
                        ])))));
  }

  Widget _imageWidget(String recipeImage, String tag) {
    return heroWidget(
        tag,
        Image(
            fit: BoxFit.cover,
            image: NetworkImage(recipeImage),
            loadingBuilder: (context, widget, progress) {
              if (progress == null) return widget;
              return Center(
                  child: CircularProgressIndicator(color: ColorManager.black));
            },
            errorBuilder: (context, object, _) {
              return const Image(
                  fit: BoxFit.cover, image: AssetImage(ImageAssets.lunch));
            }));
  }
}
