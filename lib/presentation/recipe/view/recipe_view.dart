import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:paprika/app/constants.dart';
import 'package:paprika/app/functions.dart';
import 'package:paprika/domain/model/models.dart';
import 'package:paprika/presentation/resources/assets_manager.dart';
import 'package:paprika/presentation/resources/color_manager.dart';
import 'package:paprika/presentation/resources/routes_manager.dart';
import 'package:paprika/presentation/resources/strings_manager.dart';
import 'package:paprika/presentation/resources/values_manager.dart';
import 'package:readmore/readmore.dart';

class RecipeView extends StatefulWidget {
  final RecipeData? recipe;
  final String tag;

  const RecipeView(this.recipe, this.tag, {Key? key}) : super(key: key);

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView>
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: ColorManager.lightGrey,
        body: SingleChildScrollView(
            child: SafeArea(
                child: Column(children: [
          Stack(alignment: Alignment.topLeft, children: [
            Material(
                elevation: 5,
                child: Container(
                    height: height * 0.3,
                    width: width,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.s4))),
                    child: _imageWidget(
                        widget.recipe!.recipeInformation!.image, widget.tag))),
            Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                        backgroundColor: ColorManager.black,
                        child: const Icon(Icons.arrow_back_ios_new))))
          ]),
          _titleWidget(context),
          const SizedBox(height: AppSize.s_5),
          _detailsWidget(context),
          const SizedBox(height: AppSize.s_5),
          _descriptionWidget(context),
          const SizedBox(height: AppSize.s2),
          _tabsWidget(context)
        ]))));
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

  Widget _titleWidget(BuildContext context) {
    return Container(
        color: ColorManager.white,
        child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.recipe!.recipeInformation!.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSize.s14),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                RatingBarIndicator(
                    itemCount: 5,
                    rating: (widget.recipe!.recipeInformation!.aggregateLikes /
                            5.0) %
                        5,
                    itemSize: AppSize.s16,
                    itemBuilder: (context, index) =>
                        const Icon(Icons.star, color: Colors.amberAccent)),
                const SizedBox(width: AppSize.s4),
                Text(
                    '${widget.recipe!.recipeInformation!.aggregateLikes} ${AppStrings.reviews}'),
                const Spacer(),
                const Text(AppStrings.byJohnDoe)
              ])
            ])));
  }

  Widget _detailsWidget(BuildContext context) {
    return Container(
        color: ColorManager.white,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    Text(AppStrings.time,
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: AppSize.s4),
                    Text(
                        '${widget.recipe!.recipeInformation!.readyInMinutes} ${AppStrings.minute}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 14))
                  ]),
                  Container(
                      height: 35, width: 1, color: ColorManager.lightGrey),
                  Column(children: [
                    Text(AppStrings.calories,
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: AppSize.s4),
                    Text('${widget.recipe!.recipeInformation!.healthScore}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 14))
                  ]),
                  Container(
                      height: 25, width: 1, color: ColorManager.lightGrey),
                  Column(children: [
                    Text(AppStrings.servings,
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: AppSize.s4),
                    Text('${widget.recipe!.recipeInformation!.servings}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 14))
                  ])
                ])));
  }

  Widget _descriptionWidget(BuildContext context) {
    String textCleared = widget.recipe!.recipeInformation!.summary
        .replaceAll(RegExp(r'[^\w\d\s<>]'), '');
    String text = textCleared.replaceAll(RegExp(r'<[a-zA-z0-9\s]+>'), '');

    return Container(
        color: ColorManager.white,
        padding: const EdgeInsets.all(AppPadding.p14),
        child: ReadMoreText(text,
            trimLines: 4,
            trimExpandedText: AppStrings.showLess,
            lessStyle: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 14, color: ColorManager.darkBlue),
            moreStyle: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 14, color: ColorManager.darkBlue),
            style: Theme.of(context).textTheme.labelMedium));
  }

  Widget _tabsWidget(context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
        color: ColorManager.white,
        height: height * 0.75,
        child: Column(children: [
          TabBar(
              controller: _tabController,
              tabs: const [Tab(text: AppStrings.ingredients), Tab(text: AppStrings.directions)],
              unselectedLabelColor: ColorManager.grey,
              indicatorColor: ColorManager.darkRed,
              labelColor: ColorManager.darkRed,
              labelStyle: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: ColorManager.darkRed),
              indicatorWeight: 3.0),
          const SizedBox(height: AppSize.s8),
          Flexible(
            child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: [_ingredientsWidget(), _directionsWidget()]),
          )
        ]));
  }

  Widget _ingredientsWidget() {
    return ListView.separated(
        itemBuilder: _ingredientItem,
        itemCount: widget.recipe!.recipeIngredients!.length,
        separatorBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppMargin.m12, vertical: AppMargin.m3),
              color: ColorManager.lightGrey,
              width: double.infinity,
              height: AppSize.s_2);
        });
  }

  Widget _ingredientItem(context, index) {
    String image = Constants.ingredientImageUrl +
        widget.recipe!.recipeIngredients![index].image;
    String amount =
        '${widget.recipe!.recipeIngredients![index].amount} ${widget.recipe!.recipeIngredients![index].unit}';

    return Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Row(children: [
          Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(AppSize.s12),
              color: ColorManager.white,
              child: Container(
                  height: 75,
                  width: 75,
                  padding: const EdgeInsets.all(AppPadding.p8),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      color: ColorManager.white),
                  child: Image(
                      fit: BoxFit.contain,
                      image: NetworkImage(image),
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
          const SizedBox(width: AppSize.s12),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(amount, style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: AppSize.s2),
                Text(widget.recipe!.recipeIngredients![index].nameClean,
                    style: Theme.of(context).textTheme.labelMedium)
              ])
        ]));
  }

  Widget _directionsWidget() {
    if (widget.recipe!.recipeSteps!.isNotEmpty) {
      Size size = MediaQuery.of(context).size;
      return Column(children: [
        Expanded(
            child: ListView.separated(
                itemBuilder: _directionsItem,
                itemCount: widget.recipe!.recipeSteps!.length,
                separatorBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: AppMargin.m12, vertical: AppMargin.m3),
                      color: ColorManager.lightGrey,
                      width: double.infinity,
                      height: AppSize.s_2);
                })),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.recipeSteps,
                    arguments: {'recipe': widget.recipe});
              },
              style: ElevatedButton.styleFrom(
                  elevation: 5.0,
                  backgroundColor: ColorManager.darkRed,
                  fixedSize: Size(size.width, size.height * 0.07),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s8))),
              child: const Text(AppStrings.goStepByStep)),
        )
      ]);
    }
    else {
      return Center(
        child: Text(
            AppStrings.noAvailableSteps,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    }

  }

  Widget _directionsItem(context, index) {
    return Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${AppStrings.step} ${widget.recipe!.recipeSteps![index].number}',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSize.s8),
          Text(widget.recipe!.recipeSteps![index].step,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: 16))
        ]));
  }
}
