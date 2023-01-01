import 'package:flutter/material.dart';
import 'package:paprika/domain/model/models.dart';
import 'package:paprika/presentation/resources/color_manager.dart';
import 'package:paprika/presentation/resources/values_manager.dart';

class StepsView extends StatefulWidget {
  final RecipeData recipe;

  const StepsView(this.recipe, {Key? key}) : super(key: key);

  @override
  State<StepsView> createState() => _StepsViewState();
}

class _StepsViewState extends State<StepsView> {
  int _currentStep = 1;
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: ColorManager.white,
            titleTextStyle: Theme.of(context).textTheme.headlineMedium,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:
                    Icon(Icons.arrow_back_ios_new, color: ColorManager.black)),
            title: Text(widget.recipe.recipeInformation!.title),
            bottom: PreferredSize(
                preferredSize: const Size(double.infinity, 10),
                child: LinearProgressIndicator(
                    backgroundColor: ColorManager.grey,
                    value: _value,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ColorManager.primary)))),
        body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p12, vertical: AppPadding.p2),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('${(_value * 100).round()}% Completed',
                    style: Theme.of(context).textTheme.labelMedium),
                Text('$_currentStep/${widget.recipe.recipeSteps!.length} Steps',
                    style: Theme.of(context).textTheme.labelMedium)
              ]),
              _directionsItem(),
              Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: ElevatedButton(
                      onPressed: () {
                        int count = widget.recipe.recipeSteps!.length;
                        if (_currentStep < count) {
                          setState(() {
                            _currentStep++;
                            _value = (1 / count) * _currentStep;
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 5.0,
                          primary: ColorManager.darkRed,
                          fixedSize: Size(size.width, size.height * 0.07),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSize.s8))),
                      child: Text(
                          _currentStep < widget.recipe.recipeSteps!.length
                              ? 'Next Step'
                              : 'Finish')))
            ])));
  }

  Widget _directionsItem() {
    return Flexible(
        child: Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                  'Step ${widget.recipe.recipeSteps![_currentStep - 1].number}',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSize.s12),
              Flexible(
                child: Text(widget.recipe.recipeSteps![_currentStep - 1].step,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 20)),
              )
            ])));
  }
}
