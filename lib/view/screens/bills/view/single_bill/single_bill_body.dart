part of '../bills_imports.dart';

class SingleBillBody extends StatelessWidget {
  const SingleBillBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillsCubit, BillsState>(
      builder: (context, state) {
        var cubit = BillsCubit.get(context).singleBillModel?.data;
        return CustomCondition(
          state: state is! GetSingleBillLoadingState,
          body: ListView.builder(
            itemCount: cubit?.length ?? 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var model = cubit![index];
              var client = model.client;
              return Column(
                children: [
                  BillTable(
                      billKey: 'bill_id'.tr(context),
                      value: '${model.id ?? ''}'),
                  BillTable(
                      billKey: 'created_at'.tr(context),
                      value: buildFormatDate(model)),
                  BillTable(
                      billKey: 'client_id'.tr(context),
                      value: '${model.clientId ?? ''}'),
                  BillTable(
                      billKey: 'final_price'.tr(context),
                      value: '${model.finalPrice ?? ''}'),
                  BillTable(
                      billKey: 'tax_amount'.tr(context),
                      value: '${model.taxAmount ?? ''}'),
                  BillTable(
                      billKey: 'payment_type'.tr(context),
                      value: model.paymentType ?? ''),
                  BillTable(
                      billKey: 'clint_name'.tr(context),
                      value: client?.name ?? ''),
                  BillTable(
                      billKey: 'clint_phone'.tr(context),
                      value: client?.phone ?? ''),
                  SizedBox(
                    height: (model.products!.length * 5) * 70,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: model.products!.length,
                      itemBuilder: (context, index) {
                        PrintLog.d(model.products!.length);
                        var products = model.products?[index];
                        return Column(
                          children: [
                            BillTable(
                                billKey: 'product_id'.tr(context),
                                value: '${products?.id ?? ''}'),
                            BillTable(
                                billKey: 'product_name'.tr(context),
                                value: products?.title ?? ''),
                            BillTable(
                                billKey: 'product_price'.tr(context),
                                value: '${products?.price ?? ''}'),
                            BillTable(
                                billKey: 'product_category_id'.tr(context),
                                value: '${products?.categoryId ?? ''}'),
                            BillTable(
                              billKey: 'with_tax'.tr(context),
                              value: products?.isTax == 1
                                  ? 'yes'.tr(context)
                                  : 'no'.tr(context),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  String buildFormatDate(Data model) {
    var createdAt = DateTime.parse(model.createdAt!);
    return TimeFormat.instance.formatDate(notificationFormat, createdAt);
  }
}
