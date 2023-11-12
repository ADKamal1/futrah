part of '../bills_imports.dart';

class SingleBillScreen extends StatefulWidget {
  final int id;

  const SingleBillScreen({super.key, required this.id});

  @override
  State<SingleBillScreen> createState() => _SingleBillScreenState();
}

class _SingleBillScreenState extends State<SingleBillScreen> {
  @override
  void initState() {
    var cubit = BillsCubit.get(context);
    cubit.getSingleBill(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BillsCubit, BillsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return const Scaffold(
          appBar: CustomAppBar(),
          body: SingleBillBody(),
        );
      },
    );
  }
}
