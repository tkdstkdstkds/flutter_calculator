part of 'home_page_total_price_bloc.dart';

sealed class HomePageTotalPriceState {
  final double totalPrice;

  const HomePageTotalPriceState(this.totalPrice);
}

final class HomePageTotalPriceInitialState extends HomePageTotalPriceState {
  const HomePageTotalPriceInitialState(super.totalPrice);
}

final class HomePageTotalPriceUpdateState extends HomePageTotalPriceState {
  const HomePageTotalPriceUpdateState(super.totalPrice);
}
