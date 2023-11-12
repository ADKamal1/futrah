// part of 'payment_import.dart';
//
// class PayTabs extends StatefulWidget {
//   final double amount;
//
//   const PayTabs({super.key, required this.amount});
//   @override
//   State<PayTabs> createState() => _PayTabsState();
// }
//
// class _PayTabsState extends State<PayTabs> {
//   @override
//   void initState() {
//     payPressed();
//     super.initState();
//   }
//
//   PaymentSdkConfigurationDetails generateConfig() {
//     var billingDetails = BillingDetails(
//       '',
//       'mohammad@pytic.com',
//       '+962 7 7888 2889',
//       'N Jordan St',
//       'JO',
//       'IR',
//       'JO',
//       '11152',
//     );
//     List<PaymentSdkAPms> apms = [];
//     apms.add(PaymentSdkAPms.AMAN);
//     var configuration = PaymentSdkConfigurationDetails(
//       profileId: '111004',
//       serverKey: 'SDJNHLGLWK-JGNKBGJ9WB-BDW22WMMGT',
//       clientKey: 'CBKM9M-BQVK6T-QK2T6P-MB6D7R',
//       cartId: '12433',
//       cartDescription: 'FUTRAH Company',
//       merchantName: 'FUTRAH Company',
//       screentTitle: 'Pay with Card',
//       amount: widget.amount,
//       showBillingInfo: false,
//       showShippingInfo: false,
//       forceShippingInfo: false,
//       currencyCode: 'SAR',
//       merchantCountryCode: 'SA',
//       billingDetails: billingDetails,
//       alternativePaymentMethods: apms,
//       linkBillingNameWithCardHolderName: true,
//     );
//     configuration.showBillingInfo = false;
//     configuration.showShippingInfo = false;
//     configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
//     return configuration;
//   }
//
//   Future<void> payPressed() async {
//     FlutterPaytabsBridge.startCardPayment(
//       generateConfig(),
//       (event) {
//         setState(
//           () {
//             if (event['status'] == 'success') {
//               var transactionDetails = event['data'];
//               PrintLog.d(transactionDetails);
//               if (transactionDetails['isSuccess']) {
//                 PrintLog.d('successful transaction');
//                 if (transactionDetails['isSuccess'] == true) {
//                   var cubit = SubscriptionCubit.get(context);
//                   PrintLog.d('x' * 100);
//                   PrintLog.d(cubit
//                       .subscriptionModel?.data![cubit.selectedPlanIndex].id);
//                   PrintLog.d('x' * 100);
//                   cubit.makeSubscription().then(
//                     (value) {
//                       /// TODO check this
//                       // Phoenix.rebirth(context);
//                       return pushReplacementNamed(context,  Routes.home);
//                     },
//                   );
//
//                   successSnackBar(msg: 'payment_successful'.tr(context));
//                 }
//                 if (transactionDetails['isPending']) {
//                   PrintLog.d('transaction pending');
//                 }
//               } else {
//                 PrintLog.d('failed transaction');
//                 pushReplacementNamed(context,  Routes.home);
//                 errorSnackBar(msg: 'payment_failed'.tr(context));
//               }
//
//               PrintLog.d(transactionDetails['isSuccess']);
//             } else if (event['status'] == 'error') {
//             } else if (event['status'] == 'event') {}
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     payPressed();
//     return Scaffold(
//       appBar: const CustomAppBar(),
//       body: Center(
//         child: TextButton(
//           onPressed: () => payPressed(),
//           child: MyText(title: 'pay_with_card'.tr(context)),
//         ),
//       ),
//     );
//   }
//
//   PaymentSDKQueryConfiguration generateQueryConfig() {
//     return PaymentSDKQueryConfiguration(
//       'SDJNHLGLWK-JGNKBGJ9WB-BDW22WMMGT',
//       'CBKM9M-BQVK6T-QK2T6P-MB6D7R',
//       '55419',
//       '111004',
//       'SAR',
//     );
//   }
// }
