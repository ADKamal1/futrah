part of 'add_category_imports.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = CategoryCubit.get(context);
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryInitialState) {
          final CacheHelper prefs = instance<CacheHelper>();
          AppStrings.loginToken = prefs.get(key: 'token') ?? '';
          AppStrings.userPhone = prefs.get(key: 'phone') ?? '';
          AppStrings.userUid = prefs.get(key: 'uid') ?? '';
          AppStrings.userId = prefs.get(key: 'userId') ?? 0;
        }
        if (state is AddCategoryLoadingState) const AppLoading();
        if (state is GetCategoryLoadingState) const AppLoading();
        if (state is DeleteCategoryLoadingState) const AppLoading();
        if (state is AddCategorySuccessState) {
          pushReplacementNamed(context, Routes.home);
        }
      },
      builder: (context, state) {
        return CustomCondition(
          state: state is! GetCategoryLoadingState &&
              state is! DeleteCategoryLoadingState &&
              state is! AddCategoryLoadingState,
          body: Scaffold(
            appBar: const CustomAppBar(),
            body: ListView(
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              children: [
                MyText(
                  title: 'add_categories'.tr(context),
                  size: 25,
                  fontWeight: FontWeight.bold,
                ),
                10.h,
                const CategoryListItem(),
                30.h,
                AddCategoryTextFiled(
                  controller: cubit.categoryController,
                  hintText: 'enter_cat_name'.tr(context),
                  onSubmitted: (value) {
                    cubit.categoryController.text.isEmpty
                        ? hintSnackBar(msg: 'please_add_cat'.tr(context))
                        : cubit.addNewCategory();
                  },
                ),
                10.h,
                AppButton(
                  text: 'add'.tr(context),
                  color: AppColors.green,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  borderRadius: BorderRadius.circular(6),
                  onPressed: () {

                   // Navigator.push(context, MaterialPageRoute(builder: (context) =>PrintPage(id: 385) ,));
                    //
                    cubit.categoryController.text.isEmpty
                        ? hintSnackBar(msg: 'please_add_cat'.tr(context))
                        : cubit.addNewCategory();
                  },
                ),
              ],
            ),
            bottomNavigationBar: AuthBtn(
              title: 'go_to_cat'.tr(context),
              onTap: () {
                cubit.categoryController.text.isEmpty
                    ? pushReplacementNamed(context,  Routes.addProduct)
                    : hintSnackBar(msg: 'finish_add_cat'.tr(context));
              },
            ),
          ),
        );
      },
    );
  }
}
