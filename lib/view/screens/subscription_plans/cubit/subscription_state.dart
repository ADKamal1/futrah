abstract class SubscriptionState {}

class SubscriptionInitialState extends SubscriptionState {}

class ChangeSelectedPlan extends SubscriptionState {}

class GetSubscriptionLoadingState extends SubscriptionState {}

class GetSubscriptionSuccessState extends SubscriptionState {}

class GetSubscriptionErrorState extends SubscriptionState {
  final String error;
  GetSubscriptionErrorState(this.error);
}

class MakeSubscriptionLoadingState extends SubscriptionState {}

class MakeSubscriptionSuccessState extends SubscriptionState {}

class MakeSubscriptionErrorState extends SubscriptionState {
  final String error;
  MakeSubscriptionErrorState(this.error);
}

class SelectedPlanMethodState extends SubscriptionState {}

class CardSubscriptionLoadingState extends SubscriptionState {}

class CardSubscriptionSuccessState extends SubscriptionState {}

class CardSubscriptionErrorState extends SubscriptionState {
  final String error;
  CardSubscriptionErrorState(this.error);
}
