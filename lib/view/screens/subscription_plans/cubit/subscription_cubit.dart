import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/components.dart';
import 'package:futrah/controller/constants/logger.dart';
import 'package:futrah/controller/constants/strings.dart';
import 'package:futrah/controller/services/remote/dio_helper.dart';
import 'package:futrah/controller/services/remote/end_points.dart';
import 'package:futrah/view/screens/subscription_plans/cubit/subscription_state.dart';
import 'package:futrah/view/screens/subscription_plans/model/card_subscription_model.dart';
import 'package:futrah/view/screens/subscription_plans/model/make_subscription_model.dart';
import 'package:futrah/view/screens/subscription_plans/model/subscription_model.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(SubscriptionInitialState());

  static SubscriptionCubit get(context) => BlocProvider.of(context);

  TextEditingController cardController = TextEditingController();

  /// ============================================================
  SubscriptionModel? subscriptionModel;
  Future<void> getSubscriptions() async {
    emit(GetSubscriptionLoadingState());
    await DioHelper.getData(
      url: EndPoints.subscription,
    ).then((value) {
      subscriptionModel = SubscriptionModel.fromJson(value.data);
      emit(GetSubscriptionSuccessState());
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(GetSubscriptionErrorState(error.toString()));
    });
  }

  /// ============================================================
  MakeSubscriptionModel? makeSubscriptionModel;
  Future<void> makeSubscription() async {
    emit(MakeSubscriptionLoadingState());
    FormData formData = FormData.fromMap({
      'company_id': AppStrings.userId,
      'subscription_id': subscriptionModel?.data![selectedPlanIndex].id,
    });
    await DioHelper.postData(
      url: EndPoints.makeSubscription,
      data: formData,
    ).then((value) {
      makeSubscriptionModel = MakeSubscriptionModel.fromJson(value.data);
      emit(MakeSubscriptionSuccessState());
    }).catchError((error) {
      PrintLog.d(error.toString());
      PrintLog.d(makeSubscriptionModel?.errors?.error?[0]);
      emit(MakeSubscriptionErrorState(error.toString()));
    });
  }

  /// ============================================================
  CardSubscriptionModel? cardSubscriptionModel;
  Future<void> cardSubscription() async {
    emit(CardSubscriptionLoadingState());
    FormData formData = FormData.fromMap({
      'company_id': AppStrings.userId,
      'code': cardController.text,
    });
    await DioHelper.postData(
      url: EndPoints.cardSubscription,
      data: formData,
    ).then((value) {
      cardSubscriptionModel = CardSubscriptionModel.fromJson(value.data);
      if (cardSubscriptionModel?.code == 200) {
        successSnackBar(msg: cardSubscriptionModel!.message!.toString());
        emit(CardSubscriptionSuccessState());
      } else {
        errorSnackBar(msg: cardSubscriptionModel!.message!.toString());
      }
    }).catchError((error) {
      PrintLog.e(error.toString());
      emit(CardSubscriptionErrorState(error.toString()));
    });
  }

  /// ============================================================

  int selectedPlanId = 0;
  int selectedPlanIndex = 0;
  void selectedPlanMethod({required int id, required int index}) {
    selectedPlanId = id;
    selectedPlanIndex = index;
    PrintLog.d('selected Plan=> $id\nselected Plan Index=> $index');
    emit(SelectedPlanMethodState());
  }
}
