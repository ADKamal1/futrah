part of 'home_imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    HomeCubit.get(context).getCategories();
    HomeCubit.get(context).clearCart();
    ProfileCubit.get(context).userModel;
    // requestPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        var cubit = HomeCubit.get(context);
        if (state is GetCategoriesLoadingState) const AppLoading();
        if (state is GetCategoriesErrorState) {
          cubit.getCategories();
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var pCubit = ProfileCubit.get(context);
        return WillPopScope(
          onWillPop: () => displayDialog(context),
          child: CustomCondition(
            state: state is! GetCategoriesLoadingState &&
                cubit.categoriesModel?.data != null &&
                cubit.getProductModel?.data != null,
            body: pCubit.userModel?.data?.days == 0
                ? const SubscriptionEnd()
                : Scaffold(
              drawer: const AppDrawer(),
              appBar:
              const CustomAppBar(height: 100, bottom: HomeTabBar()),
              body: CustomCondition(
                state: state is! GetProductLoadingState &&
                    cubit.getProductModel?.data != null,
                body: const HomeBody(),
              ),
              bottomNavigationBar: const QuickPaymentBtn(),
              floatingActionButtonLocation: centerFloat,
              floatingActionButton: cubit.idList.isEmpty
                  ? null
                  : CartPrice(
                title: '${cubit.total}',
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => CustomBottomSheet(
                      idList: cubit.idList,
                      productList: cubit.productList,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  FloatingActionButtonLocation get centerFloat =>
      FloatingActionButtonLocation.centerFloat;
}
