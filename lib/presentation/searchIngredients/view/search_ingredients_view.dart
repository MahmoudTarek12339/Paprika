import 'package:flutter/material.dart';
import 'package:paprika/app/constants.dart';
import 'package:paprika/app/di.dart';
import 'package:paprika/domain/model/models.dart';
import 'package:paprika/presentation/resources/assets_manager.dart';
import 'package:paprika/presentation/resources/color_manager.dart';
import 'package:paprika/presentation/resources/strings_manager.dart';
import 'package:paprika/presentation/resources/values_manager.dart';
import 'package:paprika/presentation/searchIngredients/view_model/search_ingredients_viewmodel.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SearchIngredientsView extends StatefulWidget {
  const SearchIngredientsView({Key? key}) : super(key: key);

  @override
  State<SearchIngredientsView> createState() => _SearchIngredientsViewState();
}

class _SearchIngredientsViewState extends State<SearchIngredientsView> {
  final SearchIngredientViewModel _viewModel =
      instance<SearchIngredientViewModel>();

  final _queryController = TextEditingController();

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
        appBar: AppBar(
            backgroundColor: ColorManager.white,
            titleSpacing: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context,{'ingredients':_viewModel.getIngredients()});
                },
                icon:
                    Icon(Icons.arrow_back_ios_new, color: ColorManager.black)),
            title: TextFormField(
                controller: _queryController,
                cursorColor: ColorManager.darkRed,
                onChanged: (value) {
                  _viewModel.setQuery(_queryController.text);
                },
                decoration: InputDecoration(
                    hintText: AppStrings.searchIngredients,
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () {
                          _queryController.clear();
                          _viewModel.setQuery('');
                        },
                        icon: Icon(Icons.close,
                            color: ColorManager.black, size: 18))))),
        body: SizedBox.expand(
            child: StreamBuilder<List<SearchIngredientResults>>(
                stream: _viewModel.outputSearchIngredients,
                builder: (context, snapShot) {
                  if (snapShot.hasData && snapShot.data!.isNotEmpty) {
                    return Padding(
                        padding: const EdgeInsets.all(AppPadding.p12),
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapShot.data!.length,
                            itemBuilder: (context, index) {
                              return _searchItem(snapShot.data![index]);
                            },
                            separatorBuilder: (context, index) {
                              return Container(
                                  height: AppSize.s_2,
                                  width: double.infinity,
                                  color: ColorManager.lightGrey);
                            }));
                  } else {
                    return Center(
                        child: Text(AppStrings.noResultFound,
                            style: Theme.of(context).textTheme.titleLarge));
                  }
                })));
  }

  @override
  void dispose() {
    _queryController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  Widget _searchItem(SearchIngredientResults ingredient) {
    return InkWell(
      onTap: () {
        _viewModel.updateIngredients(
            Ingredient(ingredient.name, ingredient.image,true));
      },
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(
              left: AppPadding.p8, top: AppPadding.p8, bottom: AppPadding.p8),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Material(
                  elevation: AppSize.s8,
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  color: ColorManager.white,
                  child: Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.all(AppMargin.m8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        color: ColorManager.white,
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image(
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
              StreamBuilder<List<Ingredient>>(
                  stream: _viewModel.outputIngredients,
                  builder: (context, snapShot) {
                    if (snapShot.hasData && snapShot.data!.isNotEmpty) {
                      bool selected = snapShot.data!
                          .where((e) => e.name.toLowerCase() == ingredient.name.toLowerCase())
                          .isNotEmpty;
                      if (selected) {
                        return Icon(Icons.beenhere,
                            size: AppSize.s14, color: ColorManager.darkRed);
                      } else {
                        return const SizedBox.shrink();
                      }
                    } else {
                      return const SizedBox.shrink();
                    }
                  })
            ],
          ),
        ),
        Expanded(
            child: ListTile(
                title: SubstringHighlight(
                    text: ingredient.name,
                    term: _queryController.text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontSize: 16),
                    textStyleHighlight: Theme.of(context).textTheme.labelLarge!)))
      ]),
    );
  }
}
