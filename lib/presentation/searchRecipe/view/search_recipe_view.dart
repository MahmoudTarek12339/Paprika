
import 'package:flutter/material.dart';
import 'package:paprika/app/di.dart';
import 'package:paprika/presentation/resources/color_manager.dart';
import 'package:paprika/presentation/resources/routes_manager.dart';
import 'package:paprika/presentation/resources/strings_manager.dart';
import 'package:paprika/presentation/resources/values_manager.dart';
import 'package:paprika/presentation/searchRecipe/view_model/search_recipe_viewmodel.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SearchRecipeView extends StatefulWidget {
  const SearchRecipeView({Key? key}) : super(key: key);

  @override
  State<SearchRecipeView> createState() => _SearchRecipeViewState();
}

class _SearchRecipeViewState extends State<SearchRecipeView> {
  final SearchRecipeViewModel _viewModel = instance<SearchRecipeViewModel>();

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
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new, color: ColorManager.black)),
          title: TextFormField(
              controller: _queryController,
              cursorColor: ColorManager.darkRed,
              onChanged: (value) {
                _viewModel.setQuery(_queryController.text);
              },
              decoration: InputDecoration(
                  hintText: AppStrings.searchRecipe,
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
        child: StreamBuilder<List<String>>(
          stream: _viewModel.outputRecipes,
          builder: (context, snapShot) {
            if (snapShot.hasData && snapShot.data!.isNotEmpty) {
              return Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return searchItem(snapShot.data![index]);
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                            height: AppSize.s_2,
                            width: double.infinity,
                            color: ColorManager.lightGrey);
                      },
                      itemCount: snapShot.data!.length));
            } else {
              return Center(
                  child: Text(AppStrings.noResultFound,
                      style: Theme.of(context).textTheme.titleLarge));
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _queryController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  Widget searchItem(String recipe) {
    return ListTile(
        onTap: () {
          Navigator.pushNamed(context, Routes.recipesResults,
              arguments: {'query':recipe});
        },
        title: SubstringHighlight(
            text: recipe,
            term: _queryController.text,
            overflow: TextOverflow.ellipsis,
            textStyle:
                Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16),
            textStyleHighlight: Theme.of(context).textTheme.labelLarge!));
  }
}
