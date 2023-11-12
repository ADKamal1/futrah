
part of 'bills_imports.dart';

class BillsScreen extends StatelessWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BillsCubit, BillsState>(
      listener: (context, state) {},
      builder: (context, state) {
        /*var cubit = BillsCubit.get(context);*/
        return Scaffold(
          appBar: const CustomAppBar(),
          body: CustomCondition(
            state: state is! GetAllBillsLoadingState,
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              physics: const BouncingScrollPhysics(),
              children: [
                MyText(
                  title: 'bills'.tr(context),
                  size: 20,
                  fontWeight: FontWeight.bold,
                ),
                10.h,
                const BillsListItem(),
                20.h,
                const TotalBills(),
              ],
            ),
          ),
        );
      },
    );
  }
}
