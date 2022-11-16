import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../view_model/signup_viewmodel.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();

  final AppPreferences _appPreferences = instance<AppPreferences>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();

  _bind() {
    _viewModel.start();
    _nameEditingController.addListener(() {
      _viewModel.setName(_nameEditingController.text);
    });
    _emailEditingController.addListener(() {
      _viewModel.setEmail(_emailEditingController.text);
    });

    _passwordEditingController.addListener(() {
      _viewModel.setPassword(_passwordEditingController.text);
    });

    _phoneEditingController.addListener(() {
      _viewModel.setPhone(_phoneEditingController.text);
    });
    _viewModel.isUserRegisteredInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        // navigate to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.register();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Stack(
              children: [
                Image(
                  image: const AssetImage(ImageAssets.signup),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                    top: AppSize.s60,
                    left: AppSize.s20,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        //mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: ColorManager.white,
                          ),
                          Text(
                            AppStrings.back,
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        ],
                      ),
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: AppPadding.p12),
                    child: Text(AppStrings.letsStartMakingGoodMeals,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: Colors.grey)),
                  ),
                  const SizedBox(
                    height: AppSize.s8,
                  ),
                  StreamBuilder<String?>(
                      stream: _viewModel.outputErrorName,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _nameEditingController,
                          decoration: InputDecoration(
                              hintText: AppStrings.username,
                              labelText: AppStrings.username,
                              errorText: snapshot.data),
                        );
                      }),
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                  StreamBuilder<String?>(
                      stream: _viewModel.outputErrorPhone,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: _phoneEditingController,
                          decoration: InputDecoration(
                              hintText: AppStrings.phone,
                              labelText: AppStrings.phone,
                              errorText: snapshot.data),
                        );
                      }),
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                  StreamBuilder<String?>(
                      stream: _viewModel.outputErrorEmail,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailEditingController,
                          decoration: InputDecoration(
                              hintText: AppStrings.email,
                              labelText: AppStrings.email,
                              errorText: snapshot.data),
                        );
                      }),
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                  StreamBuilder<String?>(
                      stream: _viewModel.outputErrorPassword,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          controller: _passwordEditingController,
                          decoration: InputDecoration(
                              hintText: AppStrings.password,
                              labelText: AppStrings.password,
                              errorText: snapshot.data),
                        );
                      }),
                  const SizedBox(
                    height: AppSize.s18,
                  ),
                  StreamBuilder<bool>(
                      stream: _viewModel.outputAreAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _viewModel.register();
                                    }
                                  : null,
                              child: const Text(AppStrings.createAccount)),
                        );
                      }),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text(AppStrings.termsOfUse)),
                    Text(
                      AppStrings.and,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(AppStrings.privacyPolicy))
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
