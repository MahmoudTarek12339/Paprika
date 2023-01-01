import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:paprika/app/di.dart';
import 'package:paprika/app/functions.dart';
import 'package:paprika/domain/model/models.dart';
import 'package:paprika/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:paprika/presentation/main/pages/home/view_model/home_viewmodel.dart';
import 'package:paprika/presentation/recipe/view/recipe_view.dart';
import 'package:paprika/presentation/resources/assets_manager.dart';
import 'package:paprika/presentation/resources/color_manager.dart';
import 'package:paprika/presentation/resources/strings_manager.dart';
import 'package:paprika/presentation/resources/values_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageViewModel _viewModel = instance<HomePageViewModel>();

  _bind() {
    _viewModel.start();
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
            titleSpacing: AppSize.s20,
            elevation: 1,
            title: Text(AppStrings.inspiration,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: ColorManager.darkRed))),
        body: Center(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: StreamBuilder<FlowState>(
                  stream: _viewModel.outputState,
                  builder: (context, snapshot) {
                    return snapshot.data
                            ?.getScreenWidget(context, _getContentWidget(), () {
                          _viewModel.start();
                        }) ??
                        _getContentWidget();
                  })),
        ));
  }

  Widget _getContentWidget() {
    return Column(children: [
      const SizedBox(height: AppSize.s8),
      _mayLikeWidget(context),
      const SizedBox(height: AppSize.s12),
      _masterChefWidget(context)
    ]);
  }

  Widget _mayLikeWidget(context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<List<RecipeData>>(
        stream: _viewModel.outputForYouData,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return Container(
                color: ColorManager.white,
                width: width,
                height: height * 0.38,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: AppPadding.p14,
                              right: AppPadding.p14,
                              top: AppPadding.p16),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppStrings.youMayLike,
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(AppStrings.viewAll,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: ColorManager.darkRed)),
                                )
                              ])),
                      SizedBox(height: height * 0.02),
                      Flexible(
                          child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p8),
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => _mayLikeItem(
                                  context, snapShot.data![index], index),
                              itemCount: (snapShot.data!.length) - 5))
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  Widget _mayLikeItem(context, RecipeData recipe, index) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          //navigate to next page with fade animation
          Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 700),
              reverseTransitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (context, animation, secondaryAnimation) {
                return FadeTransition(
                    opacity: animation,
                    child: RecipeView(recipe, 'soup +$index'));
              })); //here we reset image scale again

          /*Navigator.pushNamed(context, Routes.recipeDetails,
              arguments: {'recipe': recipe, 'tag': 'soup +$index'});*/
        },
        child: SizedBox(
            width: width * 0.4,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.p5),
                child: Material(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    elevation: 2,
                    child: SizedBox(
                        height: height * 0.18,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s8),
                            child: _imageWidget(recipe.recipeInformation!.image,
                                'soup +$index')))),
              ),
              const SizedBox(height: AppSize.s8),
              Flexible(
                  child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                      child: Text(recipe.recipeInformation!.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineMedium))),
              const SizedBox(height: AppSize.s4),
              Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p5),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingBarIndicator(
                            itemCount: 5,
                            rating:
                                (recipe.recipeInformation!.aggregateLikes / 5) %
                                    5,
                            itemSize: AppSize.s16,
                            itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amberAccent)),
                        const SizedBox(width: AppSize.s4),
                        Text('${recipe.recipeInformation!.aggregateLikes}')
                      ]))
            ])));
  }

  Widget _masterChefWidget(context) {
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<List<RecipeData>>(
        stream: _viewModel.outputMasterChefData,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return Container(
                color: ColorManager.white,
                width: width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: AppPadding.p14,
                              right: AppPadding.p14,
                              top: AppPadding.p16),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppStrings.masterChefChoice,
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(AppStrings.viewAll,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: ColorManager.darkRed)),
                                )
                              ])),
                      const SizedBox(height: AppSize.s20),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => _masterChefItem(
                              context, index, snapShot.data![index]),
                          itemCount: (snapShot.data!.length) - 5)
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  Widget _masterChefItem(context, index, RecipeData? recipe) {
    double height = MediaQuery.of(context).size.height;
    if (recipe != null) {
      return Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 700),
                    reverseTransitionDuration:
                        const Duration(milliseconds: 500),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                          opacity: animation,
                          child: RecipeView(recipe, 'lunch+$index'));
                    })); //here we reset image scale again
/*  Navigator.pushNamed(context, Routes.recipeDetails,
                    arguments: {'recipe': recipe, 'tag': 'lunch+$index'});
              */
              },
              child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: ColorManager.white,
                  child: Container(
                      height: height * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          color: ColorManager.white),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: height * 0.25,
                                width: double.infinity,
                                child: _imageWidget(
                                    recipe.recipeInformation!.image,
                                    'lunch+$index')),
                            const SizedBox(height: AppSize.s24),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p14),
                                child: Text(recipe.recipeInformation!.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium)),
                            const SizedBox(height: AppSize.s20),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: AppPadding.p14),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RatingBarIndicator(
                                          itemCount: 5,
                                          rating: (recipe.recipeInformation!
                                                      .aggregateLikes /
                                                  5.0) %
                                              5,
                                          itemSize: AppSize.s16,
                                          itemBuilder: (context, index) =>
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amberAccent,
                                              )),
                                      const SizedBox(width: AppSize.s4),
                                      Text(
                                          '${recipe.recipeInformation!.aggregateLikes} ${AppStrings.reviews}'),
                                      const SizedBox(width: AppSize.s16),
                                      Icon(
                                        Icons.timer_outlined,
                                        color: ColorManager.darkRed,
                                        size: 18.0,
                                      ),
                                      const SizedBox(width: AppSize.s4),
                                      Text(
                                          '${recipe.recipeInformation!.readyInMinutes} ${AppStrings.minute}')
                                    ]))
                          ])))));
    } else {
      return const SizedBox.shrink();
    }
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
