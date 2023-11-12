// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

part of '../screen/home_imports.dart';

class CustomBottomSheet extends StatefulWidget {
  final List<int> productList;
  final Map idList;

  const CustomBottomSheet(
      {super.key, required this.idList, required this.productList});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  void initState() {
    var cubit = HomeCubit.get(context);
    cubit.getAllProductModel;
    cubit.getAllProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var model = cubit.getAllProductModel;
        return widget.productList.isEmpty == true
            ? const NoDataSheet()
            : Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomCondition(
                    state:
                        state is! GetProductLoadingState && model?.data != null,
                    body: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 500,
                            child: ListView.builder(
                              itemCount: widget.productList.length,
                              itemBuilder: (context, index) {
                                int itemCount = widget.productList.length;
                                int reversedIndex = itemCount - 1 - index;
                                var product = model?.data?.firstWhere(
                                    (element) =>
                                        element.id ==
                                        widget.productList[reversedIndex]);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      AppNetworkImage(
                                          url: product?.image!.path),
                                      10.w,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText(title: '${product?.title}'),
                                          10.h,
                                          MyText(
                                              title: '${product?.price} Sar'),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          SheetBtn(
                                            icon: Icons.remove,
                                            onPressed: () {
                                              if (widget.idList[
                                                      '${product?.id}'] >
                                                  1) {
                                                widget.idList.update(
                                                    '${product?.id}',
                                                    (value) => --value);
                                                cubit.updateList();
                                                cubit.emit(
                                                    DecreaseQuantityState());
                                              }
                                              /*else {
                                                widget.idList
                                                    .remove('${product?.id}');
                                                widget.productList
                                                    .remove(product?.id);
                                                cubit.updateList();
                                                cubit.emit(
                                                    DecreaseQuantityState());
                                              }*/
                                            },
                                          ),
                                          MyText(
                                              title:
                                                  '${widget.idList['${product?.id}']}'),
                                          ElevatedButton(
                                            onPressed: () {
                                              widget.idList.update(
                                                  '${product?.id}',
                                                  (value) => ++value);
                                              cubit.emit(
                                                  DecreaseQuantityState());
                                            },
                                            style: styleFrom,
                                            child: const Icon(Icons.add,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        AppButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PayScreen(
                                  totalPrice: cubit.total,
                                  idList: widget.idList,
                                  productList: widget.productList,
                                ),
                              ),
                            );
                          },
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          color: AppColors.primaryColor,
                          height: 50,
                          child: MyText(
                            title: 'makeBill'.tr(context),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class NoDataSheet extends StatelessWidget {
  const NoDataSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyText(
        title: 'no_products'.tr(context),
        size: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SheetBtn extends StatelessWidget {
  final IconData? icon;
  final void Function() onPressed;
  const SheetBtn({super.key, this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        minimumSize: const Size(30, 30),
        shape: const CircleBorder(),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}

ButtonStyle get styleFrom {
  return ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryColor,
    minimumSize: const Size(30, 30),
    shape: const CircleBorder(),
  );
}
