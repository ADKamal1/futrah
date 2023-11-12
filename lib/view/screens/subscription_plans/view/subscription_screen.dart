part of 'subscription_import.dart';

class SubscriptionPlansScreen extends StatefulWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  State<SubscriptionPlansScreen> createState() =>
      _SubscriptionPlansScreenState();
}

class _SubscriptionPlansScreenState extends State<SubscriptionPlansScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionCubit, SubscriptionState>(
      listener: (context, state) {
        if (state is CardSubscriptionSuccessState ||
            state is MakeSubscriptionSuccessState) {
          pushReplacementNamed(context, Routes.home);
        }
        if (state is CardSubscriptionErrorState) {
          errorSnackBar(msg: 'card_not_valid'.tr(context));
        }
      },
      builder: (context, state) {
        var cubit = SubscriptionCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: const CustomAppBar(),
          body: CustomCondition(
            state: state is! CardSubscriptionLoadingState ||
                state is! MakeSubscriptionLoadingState,
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              physics: const BouncingScrollPhysics(),
              children: [
                FittedBox(
                  child: MyText(
                    title: '${'plans'.tr(context)}\n${'plan_long'.tr(context)}',
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                10.h,
                const PlansCard(),
                30.h,
                SubscriptionTextField(controller: cubit.cardController),
                30.h,
                SubscriptionBtn(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (cubit.selectedPlanId == 0 &&
                        cubit.cardController.text.isNotEmpty) {
                      cubit.cardSubscription();
                    } else if (cubit.selectedPlanId != 0) {
                      payPressed();
                    } else {
                      errorSnackBar(
                          msg: 'please_select_subscription'.tr(context));
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> payPressed() async {
    FlutterPaytabsBridge.startCardPayment(
      PayTapsData.generateConfig(context),
      (event) {
        setState(
          () {
            if (event['status'] == 'success') {
              var transactionDetails = event['data'];
              if (transactionDetails['isSuccess']) {
                if (transactionDetails['isSuccess'] == true) {
                  var cubit = SubscriptionCubit.get(context);
                  cubit.makeSubscription().then(
                        (value) => pushReplacementNamed(context, Routes.home),
                      );

                  successSnackBar(msg: 'payment_successful'.tr(context));
                }
                if (transactionDetails['isPending']) {
                  successSnackBar(msg: 'Payment Pending'.tr(context));
                }
              } else {
                successSnackBar(msg: 'Payment Failed');
                pushReplacementNamed(context, Routes.home);
                errorSnackBar(msg: 'payment_failed'.tr(context));
              }
            } else if (event['status'] == 'error') {
            } else if (event['status'] == 'event') {}
          },
        );
      },
    );
  }
}

class PayTapsData {
  // static PaymentSDKQueryConfiguration generateQueryConfig() {
  //   return PaymentSDKQueryConfiguration(
  //     'SDJNHLGLWK-JGNKBGJ9WB-BDW22WMMGT',
  //     'CBKM9M-BQVK6T-QK2T6P-MB6D7R',
  //     '55419',
  //     '111004',
  //     'SAR',
  //   );
  // }

  static PaymentSdkConfigurationDetails generateConfig(context) {
    var cubit = SubscriptionCubit.get(context);
    var price = cubit.subscriptionModel!.data![cubit.selectedPlanIndex].price;
    var billingDetails = BillingDetails(
      '',
      'mohammad@pytic.com',
      '+962 7 7888 2889',
      'N Jordan St',
      'JO',
      'IR',
      'JO',
      '11152',
    );
    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.AMAN);
    var configuration = PaymentSdkConfigurationDetails(
      profileId: '111004',
      serverKey: 'SDJNHLGLWK-JGNKBGJ9WB-BDW22WMMGT',
      clientKey: 'CBKM9M-BQVK6T-QK2T6P-MB6D7R',
      cartId: '12433',
      cartDescription: 'FUTRAH Company',
      merchantName: 'FUTRAH Company',
      screentTitle: 'Pay with Card',
      amount: price!.toDouble(),
      showBillingInfo: false,
      showShippingInfo: false,
      forceShippingInfo: false,
      currencyCode: 'SAR',
      merchantCountryCode: 'SA',
      billingDetails: billingDetails,
      alternativePaymentMethods: apms,
      linkBillingNameWithCardHolderName: true,
    );
    configuration.showBillingInfo = false;
    configuration.showShippingInfo = false;
    configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
    return configuration;
  }
}
