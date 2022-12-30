import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:paprika/app/di.dart';
import 'package:paprika/domain/model/models.dart';
import 'package:paprika/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:paprika/presentation/main/pages/home/view_model/home_viewmodel.dart';
import 'package:paprika/presentation/resources/color_manager.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.lightBlack,
        appBar: AppBar(
            backgroundColor: ColorManager.white,
            centerTitle: false,
            titleSpacing: AppSize.s20,
            elevation: 0,
            title: Text('Inspiration',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: ColorManager.darkRed))),
        body: Center(
          child: SingleChildScrollView(
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
      const SizedBox(height: AppSize.s5),
      _mayLikeWidget(context),
      const SizedBox(height: AppSize.s5),
      _masterChefWidget(context)
    ]);
  }

  /* Widget _trendingWidget(context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        color: ColorManager.white,
        width: width,
        height: height * 0.3,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p14, top: AppPadding.p16),
              child: Text('Trending',
                  style: Theme.of(context).textTheme.titleLarge)),
          SizedBox(height: height * 0.02),
          Flexible(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: _trendingItem,
                itemCount: 5),
          )
        ]));
  }

  Widget _trendingItem(context, index) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){},
      child: Column(children: [
        Material(
          elevation: 2,
          child: Container(
              height: height * 0.16,
              width: width * 0.35,
              margin: const EdgeInsets.symmetric(horizontal: AppPadding.p5),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.s8),
                  child: const Image(
                      image: AssetImage(ImageAssets.soup), fit: BoxFit.cover))),
        ),
        const SizedBox(height: AppSize.s8),
        Text('Easy Dishes', style: Theme.of(context).textTheme.headlineMedium)
      ]),
    );
  }
*/

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
                height: height * 0.34,
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
                                Text('You May Like',
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text('View All',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: ColorManager.red)),
                                )
                              ])),
                      SizedBox(height: height * 0.02),
                      Flexible(
                          child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p8),
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  _mayLikeItem(context, snapShot.data![index]),
                              itemCount: snapShot.data!.length))
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  Widget _mayLikeItem(context, RecipeData recipe) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {},
        child: SizedBox(
            width: width * 0.4,
            child: Column(children: [
              Material(
                  borderRadius: BorderRadius.circular(AppSize.s8),
                  color: ColorManager.transparent,
                  elevation: 2,
                  child: Container(
                      height: height * 0.15,
                      margin:
                          const EdgeInsets.symmetric(horizontal: AppPadding.p5),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.s8),
                          child: Image(
                              image:
                                  NetworkImage(recipe.recipeInformation!.image),
                              fit: BoxFit.cover)))),
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
                                Text('Master Chef\'s Choice',
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text('View All',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: ColorManager.red)),
                                )
                              ])),
                      const SizedBox(height: AppSize.s20),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              _masterChefItem(context, snapShot.data![index]),
                          itemCount: snapShot.data?.length)
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  Widget _masterChefItem(context, RecipeData? recipe) {
    double height = MediaQuery.of(context).size.height;
    if (recipe != null) {
      return Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
              onTap: () {},
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
                                child: Image(
                                    image: NetworkImage(
                                        recipe.recipeInformation!.image),
                                    fit: BoxFit.fitWidth)),
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
                                          '${recipe.recipeInformation!.aggregateLikes} Reviews'),
                                      const SizedBox(width: AppSize.s16),
                                      Icon(
                                        Icons.timer_outlined,
                                        color: ColorManager.darkRed,
                                        size: 18.0,
                                      ),
                                      const SizedBox(width: AppSize.s4),
                                      Text(
                                          '${recipe.recipeInformation!.readyInMinutes} min')
                                    ]))
                          ])))));
    } else {
      return const SizedBox.shrink();
    }
  }
}
